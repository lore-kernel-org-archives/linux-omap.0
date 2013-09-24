From: Benoit Cousson <bcousson@baylibre.com>
Subject: [RFC 04/15] scripts/dtc: add procedure to handle dts errors
Date: Tue, 24 Sep 2013 18:52:10 +0200
Message-ID: <1380041541-17529-5-git-send-email-bcousson@baylibre.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36766 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754311Ab3IXQwx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Sep 2013 12:52:53 -0400
Received: by mail-wi0-f180.google.com with SMTP id hj3so4218412wib.13
        for <linux-omap@vger.kernel.org>; Tue, 24 Sep 2013 09:52:51 -0700 (PDT)
In-Reply-To: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: olof@lixom.net, devicetree@vger.kernel.org, tomasz.figa@gmail.com, swarren@wwwdotorg.org, grant.likely@secretlab.ca, rob.herring@calxeda.com
Cc: khilman@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fparent@baylibre.com, Benoit Cousson <bcousson@baylibre.com>

From: Fabien Parent <fparent@baylibre.com>

The parser was not keeping enough information to allow a good error reporting.
Source Location information has been added inside a property instance to be
able to precisely tell where an error happened when a property does not match
its constraints as specified inside a schema.
Add as well a routine to print error message using these informations in case
of validation error.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---
 scripts/dtc/dtc-parser.tab.c_shipped | 595 +++++++++++++++--------------------
 scripts/dtc/dtc-parser.y             |   9 +
 scripts/dtc/dtc.h                    |   7 +
 scripts/dtc/schema.c                 |  69 ++++
 4 files changed, 345 insertions(+), 335 deletions(-)

diff --git a/scripts/dtc/dtc-parser.tab.c_shipped b/scripts/dtc/dtc-parser.tab.c_shipped
index ee1d8c3..d6d800a 100644
--- a/scripts/dtc/dtc-parser.tab.c_shipped
+++ b/scripts/dtc/dtc-parser.tab.c_shipped
@@ -1,8 +1,8 @@
-/* A Bison parser, made by GNU Bison 2.5.  */
+/* A Bison parser, made by GNU Bison 2.7.12-4996.  */
 
 /* Bison implementation for Yacc-like parsers in C
    
-      Copyright (C) 1984, 1989-1990, 2000-2011 Free Software Foundation, Inc.
+      Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
@@ -44,7 +44,7 @@
 #define YYBISON 1
 
 /* Bison version.  */
-#define YYBISON_VERSION "2.5"
+#define YYBISON_VERSION "2.7.12-4996"
 
 /* Skeleton name.  */
 #define YYSKELETON_NAME "yacc.c"
@@ -58,14 +58,11 @@
 /* Pull parsers.  */
 #define YYPULL 1
 
-/* Using locations.  */
-#define YYLSP_NEEDED 0
 
 
 
 /* Copy the first part of user declarations.  */
-
-/* Line 268 of yacc.c  */
+/* Line 371 of yacc.c  */
 #line 21 "dtc-parser.y"
 
 #include <stdio.h>
@@ -85,14 +82,16 @@ extern int treesource_error;
 static unsigned long long eval_literal(const char *s, int base, int bits);
 static unsigned char eval_char_literal(const char *s);
 
+/* Line 371 of yacc.c  */
+#line 87 "dtc-parser.tab.c"
 
-/* Line 268 of yacc.c  */
-#line 91 "dtc-parser.tab.c"
-
-/* Enabling traces.  */
-#ifndef YYDEBUG
-# define YYDEBUG 0
-#endif
+# ifndef YY_NULL
+#  if defined __cplusplus && 201103L <= __cplusplus
+#   define YY_NULL nullptr
+#  else
+#   define YY_NULL 0
+#  endif
+# endif
 
 /* Enabling verbose error messages.  */
 #ifdef YYERROR_VERBOSE
@@ -102,11 +101,14 @@ static unsigned char eval_char_literal(const char *s);
 # define YYERROR_VERBOSE 0
 #endif
 
-/* Enabling the token table.  */
-#ifndef YYTOKEN_TABLE
-# define YYTOKEN_TABLE 0
-#endif
 
+/* Enabling traces.  */
+#ifndef YYDEBUG
+# define YYDEBUG 0
+#endif
+#if YYDEBUG
+extern int yydebug;
+#endif
 
 /* Tokens.  */
 #ifndef YYTOKENTYPE
@@ -140,12 +142,10 @@ static unsigned char eval_char_literal(const char *s);
 #endif
 
 
-
 #if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
 typedef union YYSTYPE
 {
-
-/* Line 293 of yacc.c  */
+/* Line 387 of yacc.c  */
 #line 40 "dtc-parser.y"
 
 	char *propnodename;
@@ -168,21 +168,36 @@ typedef union YYSTYPE
 	uint64_t integer;
 
 
-
-/* Line 293 of yacc.c  */
-#line 174 "dtc-parser.tab.c"
+/* Line 387 of yacc.c  */
+#line 173 "dtc-parser.tab.c"
 } YYSTYPE;
 # define YYSTYPE_IS_TRIVIAL 1
 # define yystype YYSTYPE /* obsolescent; will be withdrawn */
 # define YYSTYPE_IS_DECLARED 1
 #endif
 
+extern YYSTYPE yylval;
 
-/* Copy the second part of user declarations.  */
+#ifdef YYPARSE_PARAM
+#if defined __STDC__ || defined __cplusplus
+int yyparse (void *YYPARSE_PARAM);
+#else
+int yyparse ();
+#endif
+#else /* ! YYPARSE_PARAM */
+#if defined __STDC__ || defined __cplusplus
+int yyparse (void);
+#else
+int yyparse ();
+#endif
+#endif /* ! YYPARSE_PARAM */
 
 
-/* Line 343 of yacc.c  */
-#line 186 "dtc-parser.tab.c"
+
+/* Copy the second part of user declarations.  */
+
+/* Line 390 of yacc.c  */
+#line 201 "dtc-parser.tab.c"
 
 #ifdef short
 # undef short
@@ -235,24 +250,33 @@ typedef short int yytype_int16;
 # if defined YYENABLE_NLS && YYENABLE_NLS
 #  if ENABLE_NLS
 #   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
-#   define YY_(msgid) dgettext ("bison-runtime", msgid)
+#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
 #  endif
 # endif
 # ifndef YY_
-#  define YY_(msgid) msgid
+#  define YY_(Msgid) Msgid
+# endif
+#endif
+
+#ifndef __attribute__
+/* This feature is available in gcc versions 2.5 and later.  */
+# if (! defined __GNUC__ || __GNUC__ < 2 \
+      || (__GNUC__ == 2 && __GNUC_MINOR__ < 5))
+#  define __attribute__(Spec) /* empty */
 # endif
 #endif
 
 /* Suppress unused-variable warnings by "using" E.  */
 #if ! defined lint || defined __GNUC__
-# define YYUSE(e) ((void) (e))
+# define YYUSE(E) ((void) (E))
 #else
-# define YYUSE(e) /* empty */
+# define YYUSE(E) /* empty */
 #endif
 
+
 /* Identity function, used to suppress warnings about constant conditions.  */
 #ifndef lint
-# define YYID(n) (n)
+# define YYID(N) (N)
 #else
 #if (defined __STDC__ || defined __C99__FUNC__ \
      || defined __cplusplus || defined _MSC_VER)
@@ -288,6 +312,7 @@ YYID (yyi)
 #    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
      || defined __cplusplus || defined _MSC_VER)
 #     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
+      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
 #     ifndef EXIT_SUCCESS
 #      define EXIT_SUCCESS 0
 #     endif
@@ -379,20 +404,20 @@ union yyalloc
 #endif
 
 #if defined YYCOPY_NEEDED && YYCOPY_NEEDED
-/* Copy COUNT objects from FROM to TO.  The source and destination do
+/* Copy COUNT objects from SRC to DST.  The source and destination do
    not overlap.  */
 # ifndef YYCOPY
 #  if defined __GNUC__ && 1 < __GNUC__
-#   define YYCOPY(To, From, Count) \
-      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
+#   define YYCOPY(Dst, Src, Count) \
+      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
 #  else
-#   define YYCOPY(To, From, Count)		\
-      do					\
-	{					\
-	  YYSIZE_T yyi;				\
-	  for (yyi = 0; yyi < (Count); yyi++)	\
-	    (To)[yyi] = (From)[yyi];		\
-	}					\
+#   define YYCOPY(Dst, Src, Count)              \
+      do                                        \
+        {                                       \
+          YYSIZE_T yyi;                         \
+          for (yyi = 0; yyi < (Count); yyi++)   \
+            (Dst)[yyi] = (Src)[yyi];            \
+        }                                       \
       while (YYID (0))
 #  endif
 # endif
@@ -503,17 +528,17 @@ static const yytype_int8 yyrhs[] =
 static const yytype_uint16 yyrline[] =
 {
        0,   109,   109,   118,   121,   128,   132,   140,   144,   148,
-     158,   172,   180,   183,   190,   194,   198,   202,   210,   214,
-     218,   222,   226,   243,   253,   261,   264,   268,   275,   290,
-     295,   315,   329,   336,   340,   344,   351,   355,   356,   360,
-     361,   365,   366,   370,   371,   375,   376,   380,   381,   385,
-     386,   387,   391,   392,   393,   394,   395,   399,   400,   401,
-     405,   406,   407,   411,   412,   413,   414,   418,   419,   420,
-     421,   426,   429,   433,   441,   444,   448,   456,   460,   464
+     158,   172,   180,   183,   190,   197,   204,   211,   219,   223,
+     227,   231,   235,   252,   262,   270,   273,   277,   284,   299,
+     304,   324,   338,   345,   349,   353,   360,   364,   365,   369,
+     370,   374,   375,   379,   380,   384,   385,   389,   390,   394,
+     395,   396,   400,   401,   402,   403,   404,   408,   409,   410,
+     414,   415,   416,   420,   421,   422,   423,   427,   428,   429,
+     430,   435,   438,   442,   450,   453,   457,   465,   469,   473
 };
 #endif
 
-#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
+#if YYDEBUG || YYERROR_VERBOSE || 0
 /* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
    First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
 static const char *const yytname[] =
@@ -530,7 +555,7 @@ static const char *const yytname[] =
   "integer_expr", "integer_trinary", "integer_or", "integer_and",
   "integer_bitor", "integer_bitxor", "integer_bitand", "integer_eq",
   "integer_rela", "integer_shift", "integer_add", "integer_mul",
-  "integer_unary", "bytestring", "subnodes", "subnode", 0
+  "integer_unary", "bytestring", "subnodes", "subnode", YY_NULL
 };
 #endif
 
@@ -655,10 +680,10 @@ static const yytype_uint8 yytable[] =
      137,     0,    73,   139
 };
 
-#define yypact_value_is_default(yystate) \
-  ((yystate) == (-78))
+#define yypact_value_is_default(Yystate) \
+  (!!((Yystate) == (-78)))
 
-#define yytable_value_is_error(yytable_value) \
+#define yytable_value_is_error(Yytable_value) \
   YYID (0)
 
 static const yytype_int16 yycheck[] =
@@ -727,62 +752,35 @@ static const yytype_uint8 yystos[] =
 
 #define YYRECOVERING()  (!!yyerrstatus)
 
-#define YYBACKUP(Token, Value)					\
-do								\
-  if (yychar == YYEMPTY && yylen == 1)				\
-    {								\
-      yychar = (Token);						\
-      yylval = (Value);						\
-      YYPOPSTACK (1);						\
-      goto yybackup;						\
-    }								\
-  else								\
-    {								\
+#define YYBACKUP(Token, Value)                                  \
+do                                                              \
+  if (yychar == YYEMPTY)                                        \
+    {                                                           \
+      yychar = (Token);                                         \
+      yylval = (Value);                                         \
+      YYPOPSTACK (yylen);                                       \
+      yystate = *yyssp;                                         \
+      goto yybackup;                                            \
+    }                                                           \
+  else                                                          \
+    {                                                           \
       yyerror (YY_("syntax error: cannot back up")); \
       YYERROR;							\
     }								\
 while (YYID (0))
 
-
+/* Error token number */
 #define YYTERROR	1
 #define YYERRCODE	256
 
 
-/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
-   If N is 0, then set CURRENT to the empty location which ends
-   the previous symbol: RHS[0] (always defined).  */
-
-#define YYRHSLOC(Rhs, K) ((Rhs)[K])
-#ifndef YYLLOC_DEFAULT
-# define YYLLOC_DEFAULT(Current, Rhs, N)				\
-    do									\
-      if (YYID (N))                                                    \
-	{								\
-	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
-	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
-	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
-	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
-	}								\
-      else								\
-	{								\
-	  (Current).first_line   = (Current).last_line   =		\
-	    YYRHSLOC (Rhs, 0).last_line;				\
-	  (Current).first_column = (Current).last_column =		\
-	    YYRHSLOC (Rhs, 0).last_column;				\
-	}								\
-    while (YYID (0))
-#endif
-
-
 /* This macro is provided for backward compatibility. */
-
 #ifndef YY_LOCATION_PRINT
 # define YY_LOCATION_PRINT(File, Loc) ((void) 0)
 #endif
 
 
 /* YYLEX -- calling `yylex' with the right arguments.  */
-
 #ifdef YYLEX_PARAM
 # define YYLEX yylex (YYLEX_PARAM)
 #else
@@ -832,6 +830,8 @@ yy_symbol_value_print (yyoutput, yytype, yyvaluep)
     YYSTYPE const * const yyvaluep;
 #endif
 {
+  FILE *yyo = yyoutput;
+  YYUSE (yyo);
   if (!yyvaluep)
     return;
 # ifdef YYPRINT
@@ -840,11 +840,7 @@ yy_symbol_value_print (yyoutput, yytype, yyvaluep)
 # else
   YYUSE (yyoutput);
 # endif
-  switch (yytype)
-    {
-      default:
-	break;
-    }
+  YYUSE (yytype);
 }
 
 
@@ -1083,12 +1079,11 @@ static int
 yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                 yytype_int16 *yyssp, int yytoken)
 {
-  YYSIZE_T yysize0 = yytnamerr (0, yytname[yytoken]);
+  YYSIZE_T yysize0 = yytnamerr (YY_NULL, yytname[yytoken]);
   YYSIZE_T yysize = yysize0;
-  YYSIZE_T yysize1;
   enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
   /* Internationalized format string. */
-  const char *yyformat = 0;
+  const char *yyformat = YY_NULL;
   /* Arguments of yyformat. */
   char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
   /* Number of reported tokens (one for the "unexpected", one per
@@ -1148,11 +1143,13 @@ yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                     break;
                   }
                 yyarg[yycount++] = yytname[yyx];
-                yysize1 = yysize + yytnamerr (0, yytname[yyx]);
-                if (! (yysize <= yysize1
-                       && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
-                  return 2;
-                yysize = yysize1;
+                {
+                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULL, yytname[yyx]);
+                  if (! (yysize <= yysize1
+                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
+                    return 2;
+                  yysize = yysize1;
+                }
               }
         }
     }
@@ -1172,10 +1169,12 @@ yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
 # undef YYCASE_
     }
 
-  yysize1 = yysize + yystrlen (yyformat);
-  if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
-    return 2;
-  yysize = yysize1;
+  {
+    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
+    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
+      return 2;
+    yysize = yysize1;
+  }
 
   if (*yymsg_alloc < yysize)
     {
@@ -1231,36 +1230,26 @@ yydestruct (yymsg, yytype, yyvaluep)
     yymsg = "Deleting";
   YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);
 
-  switch (yytype)
-    {
-
-      default:
-	break;
-    }
+  YYUSE (yytype);
 }
 
 
-/* Prevent warnings from -Wmissing-prototypes.  */
-#ifdef YYPARSE_PARAM
-#if defined __STDC__ || defined __cplusplus
-int yyparse (void *YYPARSE_PARAM);
-#else
-int yyparse ();
-#endif
-#else /* ! YYPARSE_PARAM */
-#if defined __STDC__ || defined __cplusplus
-int yyparse (void);
-#else
-int yyparse ();
-#endif
-#endif /* ! YYPARSE_PARAM */
 
 
 /* The lookahead symbol.  */
 int yychar;
 
+
+#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
+# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
+# define YY_IGNORE_MAYBE_UNINITIALIZED_END
+#endif
+#ifndef YY_INITIAL_VALUE
+# define YY_INITIAL_VALUE(Value) /* Nothing. */
+#endif
+
 /* The semantic value of the lookahead symbol.  */
-YYSTYPE yylval;
+YYSTYPE yylval YY_INITIAL_VALUE(yyval_default);
 
 /* Number of syntax errors so far.  */
 int yynerrs;
@@ -1300,7 +1289,7 @@ yyparse ()
        `yyss': related to states.
        `yyvs': related to semantic values.
 
-       Refer to the stacks thru separate pointers, to allow yyoverflow
+       Refer to the stacks through separate pointers, to allow yyoverflow
        to reallocate them elsewhere.  */
 
     /* The state stack.  */
@@ -1318,7 +1307,7 @@ yyparse ()
   int yyn;
   int yyresult;
   /* Lookahead token as an internal (translated) token number.  */
-  int yytoken;
+  int yytoken = 0;
   /* The variables used to return semantic value and location from the
      action routines.  */
   YYSTYPE yyval;
@@ -1336,9 +1325,8 @@ yyparse ()
      Keep to zero when no symbol should be popped.  */
   int yylen = 0;
 
-  yytoken = 0;
-  yyss = yyssa;
-  yyvs = yyvsa;
+  yyssp = yyss = yyssa;
+  yyvsp = yyvs = yyvsa;
   yystacksize = YYINITDEPTH;
 
   YYDPRINTF ((stderr, "Starting parse\n"));
@@ -1347,14 +1335,6 @@ yyparse ()
   yyerrstatus = 0;
   yynerrs = 0;
   yychar = YYEMPTY; /* Cause a token to be read.  */
-
-  /* Initialize stack pointers.
-     Waste one element of value and location stack
-     so that they stay on the same level as the state stack.
-     The wasted elements are never initialized.  */
-  yyssp = yyss;
-  yyvsp = yyvs;
-
   goto yysetstate;
 
 /*------------------------------------------------------------.
@@ -1495,7 +1475,9 @@ yybackup:
   yychar = YYEMPTY;
 
   yystate = yyn;
+  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
   *++yyvsp = yylval;
+  YY_IGNORE_MAYBE_UNINITIALIZED_END
 
   goto yynewstate;
 
@@ -1532,8 +1514,7 @@ yyreduce:
   switch (yyn)
     {
         case 2:
-
-/* Line 1806 of yacc.c  */
+/* Line 1787 of yacc.c  */
 #line 110 "dtc-parser.y"
     {
 			the_boot_info = build_boot_info((yyvsp[(3) - (4)].re), (yyvsp[(4) - (4)].node),
@@ -1542,8 +1523,7 @@ yyreduce:
     break;
 
   case 3:
-
-/* Line 1806 of yacc.c  */
+/* Line 1787 of yacc.c  */
 #line 118 "dtc-parser.y"
     {
 			(yyval.re) = NULL;
@@ -1551,8 +1531,7 @@ yyreduce:
     break;
 
   case 4:
-
-/* Line 1806 of yacc.c  */
+/* Line 1787 of yacc.c  */
 #line 122 "dtc-parser.y"
     {
 			(yyval.re) = chain_reserve_entry((yyvsp[(1) - (2)].re), (yyvsp[(2) - (2)].re));
@@ -1560,8 +1539,7 @@ yyreduce:
     break;
 
   case 5:
-
-/* Line 1806 of yacc.c  */
+/* Line 1787 of yacc.c  */
 #line 129 "dtc-parser.y"
     {
 			(yyval.re) = build_reserve_entry((yyvsp[(2) - (4)].integer), (yyvsp[(3) - (4)].integer));
@@ -1569,8 +1547,7 @@ yyreduce:
     break;
 
   case 6:
-
-/* Line 1806 of yacc.c  */
+/* Line 1787 of yacc.c  */
 #line 133 "dtc-parser.y"
     {
 			add_label(&(yyvsp[(2) - (2)].re)->labels, (yyvsp[(1) - (2)].labelref));
@@ -1579,8 +1556,7 @@ yyreduce:
     break;
 
   case 7:
-
-/* Line 1806 of yacc.c  */
+/* Line 1787 of yacc.c  */
 #line 141 "dtc-parser.y"
     {
 			(yyval.node) = name_node((yyvsp[(2) - (2)].node), "");
@@ -1588,8 +1564,7 @@ yyreduce:
     break;
 
   case 8:
-
-/* Line 1806 of yacc.c  */
+/* Line 1787 of yacc.c  */
 #line 145 "dtc-parser.y"
     {
 			(yyval.node) = merge_nodes((yyvsp[(1) - (3)].node), (yyvsp[(3) - (3)].node));
@@ -1597,8 +1572,7 @@ yyreduce:
     break;
 
   case 9:
-
-/* Line 1806 of yacc.c  */
+/* Line 1787 of yacc.c  */
 #line 149 "dtc-parser.y"
     {
 			struct node *target = get_node_by_ref((yyvsp[(1) - (3)].node), (yyvsp[(2) - (3)].labelref));
@@ -1612,8 +1586,7 @@ yyreduce:
     break;
 
   case 10:
-
-/* Line 1806 of yacc.c  */
+/* Line 1787 of yacc.c  */
 #line 159 "dtc-parser.y"
     {
 			struct node *target = get_node_by_ref((yyvsp[(1) - (4)].node), (yyvsp[(3) - (4)].labelref));
@@ -1628,8 +1601,7 @@ yyreduce:
     break;
 
   case 11:
-
-/* Line 1806 of yacc.c  */
+/* Line 1787 of yacc.c  */
 #line 173 "dtc-parser.y"
     {
 			(yyval.node) = build_node((yyvsp[(2) - (5)].proplist), (yyvsp[(3) - (5)].nodelist));
@@ -1637,8 +1609,7 @@ yyreduce:
     break;
 
   case 12:
-
-/* Line 1806 of yacc.c  */
+/* Line 1787 of yacc.c  */
 #line 180 "dtc-parser.y"
     {
 			(yyval.proplist) = NULL;
@@ -1646,8 +1617,7 @@ yyreduce:
     break;
 
   case 13:
-
-/* Line 1806 of yacc.c  */
+/* Line 1787 of yacc.c  */
 #line 184 "dtc-parser.y"
     {
 			(yyval.proplist) = chain_property((yyvsp[(2) - (2)].prop), (yyvsp[(1) - (2)].proplist));
@@ -1655,36 +1625,41 @@ yyreduce:
     break;
 
   case 14:
-
-/* Line 1806 of yacc.c  */
+/* Line 1787 of yacc.c  */
 #line 191 "dtc-parser.y"
     {
 			(yyval.prop) = build_property((yyvsp[(1) - (4)].propnodename), (yyvsp[(3) - (4)].data));
+			(yyval.prop)->loc.line = yylloc.first_line;
+			(yyval.prop)->loc.col = yylloc.first_column;
+			(yyval.prop)->loc.file = yylloc.file->name;
 		}
     break;
 
   case 15:
-
-/* Line 1806 of yacc.c  */
-#line 195 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 198 "dtc-parser.y"
     {
 			(yyval.prop) = build_property((yyvsp[(1) - (2)].propnodename), empty_data);
+			(yyval.prop)->loc.line = yylloc.first_line;
+			(yyval.prop)->loc.col = yylloc.first_column;
+			(yyval.prop)->loc.file = yylloc.file->name;
 		}
     break;
 
   case 16:
-
-/* Line 1806 of yacc.c  */
-#line 199 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 205 "dtc-parser.y"
     {
 			(yyval.prop) = build_property_delete((yyvsp[(2) - (3)].propnodename));
+			(yyval.prop)->loc.line = yylloc.first_line;
+			(yyval.prop)->loc.col = yylloc.first_column;
+			(yyval.prop)->loc.file = yylloc.file->name;
 		}
     break;
 
   case 17:
-
-/* Line 1806 of yacc.c  */
-#line 203 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 212 "dtc-parser.y"
     {
 			add_label(&(yyvsp[(2) - (2)].prop)->labels, (yyvsp[(1) - (2)].labelref));
 			(yyval.prop) = (yyvsp[(2) - (2)].prop);
@@ -1692,45 +1667,40 @@ yyreduce:
     break;
 
   case 18:
-
-/* Line 1806 of yacc.c  */
-#line 211 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 220 "dtc-parser.y"
     {
 			(yyval.data) = data_merge((yyvsp[(1) - (2)].data), (yyvsp[(2) - (2)].data));
 		}
     break;
 
   case 19:
-
-/* Line 1806 of yacc.c  */
-#line 215 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 224 "dtc-parser.y"
     {
 			(yyval.data) = data_merge((yyvsp[(1) - (3)].data), (yyvsp[(2) - (3)].array).data);
 		}
     break;
 
   case 20:
-
-/* Line 1806 of yacc.c  */
-#line 219 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 228 "dtc-parser.y"
     {
 			(yyval.data) = data_merge((yyvsp[(1) - (4)].data), (yyvsp[(3) - (4)].data));
 		}
     break;
 
   case 21:
-
-/* Line 1806 of yacc.c  */
-#line 223 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 232 "dtc-parser.y"
     {
 			(yyval.data) = data_add_marker((yyvsp[(1) - (2)].data), REF_PATH, (yyvsp[(2) - (2)].labelref));
 		}
     break;
 
   case 22:
-
-/* Line 1806 of yacc.c  */
-#line 227 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 236 "dtc-parser.y"
     {
 			FILE *f = srcfile_relative_open((yyvsp[(4) - (9)].data).val, NULL);
 			struct data d;
@@ -1750,9 +1720,8 @@ yyreduce:
     break;
 
   case 23:
-
-/* Line 1806 of yacc.c  */
-#line 244 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 253 "dtc-parser.y"
     {
 			FILE *f = srcfile_relative_open((yyvsp[(4) - (5)].data).val, NULL);
 			struct data d = empty_data;
@@ -1765,45 +1734,40 @@ yyreduce:
     break;
 
   case 24:
-
-/* Line 1806 of yacc.c  */
-#line 254 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 263 "dtc-parser.y"
     {
 			(yyval.data) = data_add_marker((yyvsp[(1) - (2)].data), LABEL, (yyvsp[(2) - (2)].labelref));
 		}
     break;
 
   case 25:
-
-/* Line 1806 of yacc.c  */
-#line 261 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 270 "dtc-parser.y"
     {
 			(yyval.data) = empty_data;
 		}
     break;
 
   case 26:
-
-/* Line 1806 of yacc.c  */
-#line 265 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 274 "dtc-parser.y"
     {
 			(yyval.data) = (yyvsp[(1) - (2)].data);
 		}
     break;
 
   case 27:
-
-/* Line 1806 of yacc.c  */
-#line 269 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 278 "dtc-parser.y"
     {
 			(yyval.data) = data_add_marker((yyvsp[(1) - (2)].data), LABEL, (yyvsp[(2) - (2)].labelref));
 		}
     break;
 
   case 28:
-
-/* Line 1806 of yacc.c  */
-#line 276 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 285 "dtc-parser.y"
     {
 			(yyval.array).data = empty_data;
 			(yyval.array).bits = eval_literal((yyvsp[(2) - (3)].literal), 0, 7);
@@ -1821,9 +1785,8 @@ yyreduce:
     break;
 
   case 29:
-
-/* Line 1806 of yacc.c  */
-#line 291 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 300 "dtc-parser.y"
     {
 			(yyval.array).data = empty_data;
 			(yyval.array).bits = 32;
@@ -1831,9 +1794,8 @@ yyreduce:
     break;
 
   case 30:
-
-/* Line 1806 of yacc.c  */
-#line 296 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 305 "dtc-parser.y"
     {
 			if ((yyvsp[(1) - (2)].array).bits < 64) {
 				uint64_t mask = (1ULL << (yyvsp[(1) - (2)].array).bits) - 1;
@@ -1856,9 +1818,8 @@ yyreduce:
     break;
 
   case 31:
-
-/* Line 1806 of yacc.c  */
-#line 316 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 325 "dtc-parser.y"
     {
 			uint64_t val = ~0ULL >> (64 - (yyvsp[(1) - (2)].array).bits);
 
@@ -1875,244 +1836,212 @@ yyreduce:
     break;
 
   case 32:
-
-/* Line 1806 of yacc.c  */
-#line 330 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 339 "dtc-parser.y"
     {
 			(yyval.array).data = data_add_marker((yyvsp[(1) - (2)].array).data, LABEL, (yyvsp[(2) - (2)].labelref));
 		}
     break;
 
   case 33:
-
-/* Line 1806 of yacc.c  */
-#line 337 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 346 "dtc-parser.y"
     {
 			(yyval.integer) = eval_literal((yyvsp[(1) - (1)].literal), 0, 64);
 		}
     break;
 
   case 34:
-
-/* Line 1806 of yacc.c  */
-#line 341 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 350 "dtc-parser.y"
     {
 			(yyval.integer) = eval_char_literal((yyvsp[(1) - (1)].literal));
 		}
     break;
 
   case 35:
-
-/* Line 1806 of yacc.c  */
-#line 345 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 354 "dtc-parser.y"
     {
 			(yyval.integer) = (yyvsp[(2) - (3)].integer);
 		}
     break;
 
   case 38:
-
-/* Line 1806 of yacc.c  */
-#line 356 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 365 "dtc-parser.y"
     { (yyval.integer) = (yyvsp[(1) - (5)].integer) ? (yyvsp[(3) - (5)].integer) : (yyvsp[(5) - (5)].integer); }
     break;
 
   case 40:
-
-/* Line 1806 of yacc.c  */
-#line 361 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 370 "dtc-parser.y"
     { (yyval.integer) = (yyvsp[(1) - (3)].integer) || (yyvsp[(3) - (3)].integer); }
     break;
 
   case 42:
-
-/* Line 1806 of yacc.c  */
-#line 366 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 375 "dtc-parser.y"
     { (yyval.integer) = (yyvsp[(1) - (3)].integer) && (yyvsp[(3) - (3)].integer); }
     break;
 
   case 44:
-
-/* Line 1806 of yacc.c  */
-#line 371 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 380 "dtc-parser.y"
     { (yyval.integer) = (yyvsp[(1) - (3)].integer) | (yyvsp[(3) - (3)].integer); }
     break;
 
   case 46:
-
-/* Line 1806 of yacc.c  */
-#line 376 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 385 "dtc-parser.y"
     { (yyval.integer) = (yyvsp[(1) - (3)].integer) ^ (yyvsp[(3) - (3)].integer); }
     break;
 
   case 48:
-
-/* Line 1806 of yacc.c  */
-#line 381 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 390 "dtc-parser.y"
     { (yyval.integer) = (yyvsp[(1) - (3)].integer) & (yyvsp[(3) - (3)].integer); }
     break;
 
   case 50:
-
-/* Line 1806 of yacc.c  */
-#line 386 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 395 "dtc-parser.y"
     { (yyval.integer) = (yyvsp[(1) - (3)].integer) == (yyvsp[(3) - (3)].integer); }
     break;
 
   case 51:
-
-/* Line 1806 of yacc.c  */
-#line 387 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 396 "dtc-parser.y"
     { (yyval.integer) = (yyvsp[(1) - (3)].integer) != (yyvsp[(3) - (3)].integer); }
     break;
 
   case 53:
-
-/* Line 1806 of yacc.c  */
-#line 392 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 401 "dtc-parser.y"
     { (yyval.integer) = (yyvsp[(1) - (3)].integer) < (yyvsp[(3) - (3)].integer); }
     break;
 
   case 54:
-
-/* Line 1806 of yacc.c  */
-#line 393 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 402 "dtc-parser.y"
     { (yyval.integer) = (yyvsp[(1) - (3)].integer) > (yyvsp[(3) - (3)].integer); }
     break;
 
   case 55:
-
-/* Line 1806 of yacc.c  */
-#line 394 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 403 "dtc-parser.y"
     { (yyval.integer) = (yyvsp[(1) - (3)].integer) <= (yyvsp[(3) - (3)].integer); }
     break;
 
   case 56:
-
-/* Line 1806 of yacc.c  */
-#line 395 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 404 "dtc-parser.y"
     { (yyval.integer) = (yyvsp[(1) - (3)].integer) >= (yyvsp[(3) - (3)].integer); }
     break;
 
   case 57:
-
-/* Line 1806 of yacc.c  */
-#line 399 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 408 "dtc-parser.y"
     { (yyval.integer) = (yyvsp[(1) - (3)].integer) << (yyvsp[(3) - (3)].integer); }
     break;
 
   case 58:
-
-/* Line 1806 of yacc.c  */
-#line 400 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 409 "dtc-parser.y"
     { (yyval.integer) = (yyvsp[(1) - (3)].integer) >> (yyvsp[(3) - (3)].integer); }
     break;
 
   case 60:
-
-/* Line 1806 of yacc.c  */
-#line 405 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 414 "dtc-parser.y"
     { (yyval.integer) = (yyvsp[(1) - (3)].integer) + (yyvsp[(3) - (3)].integer); }
     break;
 
   case 61:
-
-/* Line 1806 of yacc.c  */
-#line 406 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 415 "dtc-parser.y"
     { (yyval.integer) = (yyvsp[(1) - (3)].integer) - (yyvsp[(3) - (3)].integer); }
     break;
 
   case 63:
-
-/* Line 1806 of yacc.c  */
-#line 411 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 420 "dtc-parser.y"
     { (yyval.integer) = (yyvsp[(1) - (3)].integer) * (yyvsp[(3) - (3)].integer); }
     break;
 
   case 64:
-
-/* Line 1806 of yacc.c  */
-#line 412 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 421 "dtc-parser.y"
     { (yyval.integer) = (yyvsp[(1) - (3)].integer) / (yyvsp[(3) - (3)].integer); }
     break;
 
   case 65:
-
-/* Line 1806 of yacc.c  */
-#line 413 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 422 "dtc-parser.y"
     { (yyval.integer) = (yyvsp[(1) - (3)].integer) % (yyvsp[(3) - (3)].integer); }
     break;
 
   case 68:
-
-/* Line 1806 of yacc.c  */
-#line 419 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 428 "dtc-parser.y"
     { (yyval.integer) = -(yyvsp[(2) - (2)].integer); }
     break;
 
   case 69:
-
-/* Line 1806 of yacc.c  */
-#line 420 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 429 "dtc-parser.y"
     { (yyval.integer) = ~(yyvsp[(2) - (2)].integer); }
     break;
 
   case 70:
-
-/* Line 1806 of yacc.c  */
-#line 421 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 430 "dtc-parser.y"
     { (yyval.integer) = !(yyvsp[(2) - (2)].integer); }
     break;
 
   case 71:
-
-/* Line 1806 of yacc.c  */
-#line 426 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 435 "dtc-parser.y"
     {
 			(yyval.data) = empty_data;
 		}
     break;
 
   case 72:
-
-/* Line 1806 of yacc.c  */
-#line 430 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 439 "dtc-parser.y"
     {
 			(yyval.data) = data_append_byte((yyvsp[(1) - (2)].data), (yyvsp[(2) - (2)].byte));
 		}
     break;
 
   case 73:
-
-/* Line 1806 of yacc.c  */
-#line 434 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 443 "dtc-parser.y"
     {
 			(yyval.data) = data_add_marker((yyvsp[(1) - (2)].data), LABEL, (yyvsp[(2) - (2)].labelref));
 		}
     break;
 
   case 74:
-
-/* Line 1806 of yacc.c  */
-#line 441 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 450 "dtc-parser.y"
     {
 			(yyval.nodelist) = NULL;
 		}
     break;
 
   case 75:
-
-/* Line 1806 of yacc.c  */
-#line 445 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 454 "dtc-parser.y"
     {
 			(yyval.nodelist) = chain_node((yyvsp[(1) - (2)].node), (yyvsp[(2) - (2)].nodelist));
 		}
     break;
 
   case 76:
-
-/* Line 1806 of yacc.c  */
-#line 449 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 458 "dtc-parser.y"
     {
 			print_error("syntax error: properties must precede subnodes");
 			YYERROR;
@@ -2120,27 +2049,24 @@ yyreduce:
     break;
 
   case 77:
-
-/* Line 1806 of yacc.c  */
-#line 457 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 466 "dtc-parser.y"
     {
 			(yyval.node) = name_node((yyvsp[(2) - (2)].node), (yyvsp[(1) - (2)].propnodename));
 		}
     break;
 
   case 78:
-
-/* Line 1806 of yacc.c  */
-#line 461 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 470 "dtc-parser.y"
     {
 			(yyval.node) = name_node(build_node_delete(), (yyvsp[(2) - (3)].propnodename));
 		}
     break;
 
   case 79:
-
-/* Line 1806 of yacc.c  */
-#line 465 "dtc-parser.y"
+/* Line 1787 of yacc.c  */
+#line 474 "dtc-parser.y"
     {
 			add_label(&(yyvsp[(2) - (2)].node)->labels, (yyvsp[(1) - (2)].labelref));
 			(yyval.node) = (yyvsp[(2) - (2)].node);
@@ -2148,9 +2074,8 @@ yyreduce:
     break;
 
 
-
-/* Line 1806 of yacc.c  */
-#line 2154 "dtc-parser.tab.c"
+/* Line 1787 of yacc.c  */
+#line 2079 "dtc-parser.tab.c"
       default: break;
     }
   /* User semantic actions sometimes alter yychar, and that requires
@@ -2313,7 +2238,9 @@ yyerrlab1:
       YY_STACK_PRINT (yyss, yyssp);
     }
 
+  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
   *++yyvsp = yylval;
+  YY_IGNORE_MAYBE_UNINITIALIZED_END
 
 
   /* Shift the error token.  */
@@ -2337,7 +2264,7 @@ yyabortlab:
   yyresult = 1;
   goto yyreturn;
 
-#if !defined(yyoverflow) || YYERROR_VERBOSE
+#if !defined yyoverflow || YYERROR_VERBOSE
 /*-------------------------------------------------.
 | yyexhaustedlab -- memory exhaustion comes here.  |
 `-------------------------------------------------*/
@@ -2379,9 +2306,8 @@ yyreturn:
 }
 
 
-
-/* Line 2067 of yacc.c  */
-#line 471 "dtc-parser.y"
+/* Line 2050 of yacc.c  */
+#line 480 "dtc-parser.y"
 
 
 void print_error(char const *fmt, ...)
@@ -2444,4 +2370,3 @@ static unsigned char eval_char_literal(const char *s)
 
 	return c;
 }
-
diff --git a/scripts/dtc/dtc-parser.y b/scripts/dtc/dtc-parser.y
index f412460..af4329a 100644
--- a/scripts/dtc/dtc-parser.y
+++ b/scripts/dtc/dtc-parser.y
@@ -190,14 +190,23 @@ propdef:
 	  DT_PROPNODENAME '=' propdata ';'
 		{
 			$$ = build_property($1, $3);
+			$$->loc.line = yylloc.first_line;
+			$$->loc.col = yylloc.first_column;
+			$$->loc.file = yylloc.file->name;
 		}
 	| DT_PROPNODENAME ';'
 		{
 			$$ = build_property($1, empty_data);
+			$$->loc.line = yylloc.first_line;
+			$$->loc.col = yylloc.first_column;
+			$$->loc.file = yylloc.file->name;
 		}
 	| DT_DEL_PROP DT_PROPNODENAME ';'
 		{
 			$$ = build_property_delete($2);
+			$$->loc.line = yylloc.first_line;
+			$$->loc.col = yylloc.first_column;
+			$$->loc.file = yylloc.file->name;
 		}
 	| DT_LABEL propdef
 		{
diff --git a/scripts/dtc/dtc.h b/scripts/dtc/dtc.h
index 2b14b3a..e61dde7 100644
--- a/scripts/dtc/dtc.h
+++ b/scripts/dtc/dtc.h
@@ -133,6 +133,12 @@ struct label {
 	struct label *next;
 };
 
+struct srcloc {
+	int line;
+	int col;
+	const char *file;
+};
+
 struct property {
 	int deleted;
 	char *name;
@@ -141,6 +147,7 @@ struct property {
 	struct property *next;
 
 	struct label *labels;
+	struct srcloc loc;
 };
 
 struct node {
diff --git a/scripts/dtc/schema.c b/scripts/dtc/schema.c
index a797821..b190241 100644
--- a/scripts/dtc/schema.c
+++ b/scripts/dtc/schema.c
@@ -4,6 +4,23 @@
 #include <sys/types.h>
 #include <dirent.h>
 #include <pcre.h>
+#include <stdio.h>
+
+#define DT_ERROR(path, p, format, ...) \
+	do { \
+		dt_error(path, p, format, ##__VA_ARGS__); \
+		ret = 0; \
+		goto end; \
+	} while (0)
+
+#define DT_ERROR_IF(assertion, path, p, format, ...) \
+	do { \
+		if (!(assertion)) \
+			break; \
+		dt_error(path, p, format, ##__VA_ARGS__); \
+		ret = 0; \
+		goto end; \
+	} while (0)
 
 static const char *const SCHEMA_EXT = ".schema";
 static const char *const VALUE_PROPNAME = "value";
@@ -94,6 +111,22 @@ static struct property *get_property_matching_pattern(struct property **list,
 	return p;
 }
 
+static char *build_path(struct node_list *path)
+{
+	char *str = xstrdup("");
+	char *p = NULL;
+
+	for (; path; path = path->next) {
+		assert(path->n);
+
+		assert(asprintf(&p, "%s/%s", path->n->name, str) != -1);
+
+		free(str);
+		str = p;
+	}
+	return str;
+}
+
 static int is_prop_value(const char *p)
 {
 	int is_value = 1;
@@ -110,6 +143,42 @@ static int is_prop_value(const char *p)
 
 /** Schema Validation */
 
+static void dt_error(struct node_list *path,
+		     struct property *p,
+		     const char *format, ...)
+		__attribute__((format(printf, 3, 4)));
+
+static void dt_error(struct node_list *path,
+		     struct property *p,
+		     const char *format, ...)
+{
+	char *strpath;
+	va_list vl;
+	va_start(vl, format);
+
+	assert(format);
+
+	fprintf(stderr, "FATAL ERROR");
+	if (p) {
+		fprintf(stderr, " in %s:%d:%d",
+			p->loc.file, p->loc.line, p->loc.col);
+	}
+	fprintf(stderr, " | ");
+
+	if (path) {
+		strpath = build_path(path);
+		fprintf(stderr, "%s", strpath);
+		free(strpath);
+	}
+
+	fprintf(stderr, "%s: ", p ? p->name : "");
+	vfprintf(stderr, format, vl);
+
+	va_end(vl);
+	if (exit_on_failure)
+		exit(1);
+}
+
 static void free_property_constraints(struct prop_constraints *pc)
 {
 	if (!pc)
-- 
1.8.1.2

