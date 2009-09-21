From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC] DSPBRIDGE: Kill CAMelCaSiNg
Date: Mon, 21 Sep 2009 16:12:51 +0300
Message-ID: <5ec8ebd50909210612r24d2fbcdm438dfb6d31c86208@mail.gmail.com>
References: <4AB2464C.6010005@ti.com>
	 <94a0d4530909210505n2871f902yb5b5885547fbaefc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:57250 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756081AbZIUNMt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Sep 2009 09:12:49 -0400
Received: by ewy2 with SMTP id 2so928804ewy.17
        for <linux-omap@vger.kernel.org>; Mon, 21 Sep 2009 06:12:51 -0700 (PDT)
In-Reply-To: <94a0d4530909210505n2871f902yb5b5885547fbaefc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Sep 21, 2009 at 3:05 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Yes, I think we should do that, and make some sort of release,
> possibly squashing all the changes... my current branch counts 218
> commits.
I think it should be somehow announced before. Because, f.e., my
patches is so big to rewrite them
(and most of them are accepted already, although I can't see commits
in public repository)

> I did a few more cleanups (yeah, I'm too picky) and here's the result=
=2E
Actually even this could be simplified :-)

> #**
> #* @brief - changes camel casing to ones with smaller case
> #*
> camel_to_norm() {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo $1 | tr '\_' '+' | sed 's/\([A-Z]\)/_=
\l\1/g' | sed
> 's/^_\([a-z]\)/\1/g' | \
I suppose there is could be used code like: sed -e '<expr1>; <expr2>'
instead of two or more sed calls.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0tr 'A-Z' 'a-z' | sed "s/\([a-z][a-z]\+\)/-=
\1-/g" | tr -d '_'| \
tr -d '_' is the 's/_//g' expression for sed

> =C2=A0 =C2=A0 =C2=A0 =C2=A0tr '-' '_' | sed -e "s/_$//g" | sed -e "s/=
^_//g" | tr '+' '_' | \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sed -e "s/__*/_/g" | sed -e "s/_\([0-9][0-=
9]*\)/\1/g" | \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sed -e "s/^[a-z]\_\([a-z][a-z]\+\)/\1/g"
The similar. It could be optimized to a few sed calls (perhaps even to
one call with all expressions in a sequence).

> # grab the output for only the ones we want..
> grep "$DIR_FILE" tags | grep -v "^\!" | sed -e
> "s/\/\^.*\"/REPLACE_1/g" > $TMPFILE
sed could match and skip lines like grep -v 'smth.': sed -e '/^!/d; ...=
'

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dos2unix -n $file $TMPFILE1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sed -e "s/\<$token\>/$new/g" =
$TMPFILE1 > $file
dos2unix actually one expression for sed, AFAIK.
And new sed versions (starting from 3.8?) have -i which means 'in place=
'.

P.S. And personally I prefer to use perl :-)

--=20
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
