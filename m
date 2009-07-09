From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 1/4] DSPBRIDGE: Fix macros that break when inside an
 if/else
Date: Thu, 9 Jul 2009 18:51:12 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A30E140D@dlee06.ent.ti.com>
References: <1246978928-7139-1-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51788 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718AbZGIXvU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jul 2009 19:51:20 -0400
In-Reply-To: <1246978928-7139-1-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "ext-phil.2.carmody@nokia.com" <ext-phil.2.carmody@nokia.com>


Thanks for the patch, it only has indentation problems, this is the checkpatch output:

WARNING: suspect code indent for conditional statements (8, 12)
#34: FILE: drivers/dsp/bridge/pmgr/wcd.c:152:
+       if (DSP_SUCCEEDED(status)) {                    \
+           if (unlikely((src) == NULL) ||              \

WARNING: line over 80 characters
#36: FILE: drivers/dsp/bridge/pmgr/wcd.c:154:
+               unlikely(copy_from_user(dest, src, (elements) * sizeof(*(dest))))) { \

WARNING: suspect code indent for conditional statements (8, 12)
#46: FILE: drivers/dsp/bridge/pmgr/wcd.c:164:
+       if (DSP_SUCCEEDED(status)) {                    \
+           if (unlikely((dest) == NULL) ||                             \

WARNING: line over 80 characters
#48: FILE: drivers/dsp/bridge/pmgr/wcd.c:166:
+               unlikely(copy_to_user(dest, src, (elements) * sizeof(*(src))))) { \

total: 0 errors, 4 warnings, 48 lines checked

Could you please fix that warning please?

Regards,
Fernando.


> -----Original Message-----
> From: Ameya Palande [mailto:ameya.palande@nokia.com]
> Sent: Tuesday, July 07, 2009 10:02 AM
> To: linux-omap@vger.kernel.org
> Cc: Guzman Lugo, Fernando; Kanigeri, Hari; ext-phil.2.carmody@nokia.com
> Subject: [PATCH 1/4] DSPBRIDGE: Fix macros that break when inside an
> if/else
> 
> From: Phil Carmody <ext-phil.2.carmody@nokia.com>
> 
> cp_{to,fm}_usr break if between an if and an else (with no {}).
> 
> http://www.faqs.org/faqs/C-faq/abridged/
> 10.4: What's the best way to write a multi-statement macro?
> A:    #define Func() do {stmt1; stmt2; ... } while(0) /* (no trailing ;)
> */
> 
> Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
> ---
>  drivers/dsp/bridge/pmgr/wcd.c |   42 ++++++++++++++++++++++--------------
> ----
>  1 files changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
> index 86812c6..aaf3019 100644
> --- a/drivers/dsp/bridge/pmgr/wcd.c
> +++ b/drivers/dsp/bridge/pmgr/wcd.c
> @@ -147,25 +147,29 @@
> 
>  /* Following two macros should ideally have do{}while(0) */
> 
> -#define cp_fm_usr(dest, src, status, elements)    \
> -    if (DSP_SUCCEEDED(status)) {\
> -	    if (unlikely(src == NULL) ||				\
> -		unlikely(copy_from_user(dest, src, elements *
> sizeof(*(dest))))) { \
> -		GT_1trace(WCD_debugMask, GT_7CLASS, \
> -		"copy_from_user failed, src=0x%x\n", src);  \
> -		status = DSP_EPOINTER ; \
> -	} \
> -    }
> -
> -#define cp_to_usr(dest, src, status, elements)    \
> -    if (DSP_SUCCEEDED(status)) {\
> -	    if (unlikely(dest == NULL) ||				\
> -		unlikely(copy_to_user(dest, src, elements * sizeof(*(src)))))
> { \
> -		GT_1trace(WCD_debugMask, GT_7CLASS, \
> -		"copy_to_user failed, dest=0x%x\n", dest); \
> -		status = DSP_EPOINTER ;\
> -	} \
> -    }
> +#define cp_fm_usr(dest, src, status, elements)	\
> +    do {						\
> +	if (DSP_SUCCEEDED(status)) {			\
> +	    if (unlikely((src) == NULL) ||		\
> +		unlikely(copy_from_user(dest, src, (elements) *
> sizeof(*(dest))))) { \
> +		GT_1trace(WCD_debugMask, GT_7CLASS,	\
> +			  "copy_from_user failed, src=0x%x\n", src);	\
> +		(status) = DSP_EPOINTER ;				\
> +	    }						\
> +	}						\
> +    } while (0)
> +
> +#define cp_to_usr(dest, src, status, elements) \
> +    do {						\
> +	if (DSP_SUCCEEDED(status)) {			\
> +	    if (unlikely((dest) == NULL) ||				\
> +		unlikely(copy_to_user(dest, src, (elements) *
> sizeof(*(src))))) { \
> +		GT_1trace(WCD_debugMask, GT_7CLASS,	\
> +			  "copy_to_user failed, dest=0x%x\n", dest);	\
> +		(status) = DSP_EPOINTER ;		\
> +	    }						\
> +	}						\
> +    } while (0)
> 
>  /* Device IOCtl function pointer */
>  struct WCD_Cmd {
> --
> 1.6.2.4
> 

