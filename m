From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 6/6] DSPBRIDGE: Use _IOxx macro to define ioctls
Date: Mon, 11 Jan 2010 14:11:24 -0600
Message-ID: <4B4B85EC.4050803@ti.com>
References: <1263240766-13000-1-git-send-email-omar.ramirez@ti.com> <1263240766-13000-2-git-send-email-omar.ramirez@ti.com> <1263240766-13000-3-git-send-email-omar.ramirez@ti.com> <1263240766-13000-4-git-send-email-omar.ramirez@ti.com> <1263240766-13000-5-git-send-email-omar.ramirez@ti.com> <1263240766-13000-6-git-send-email-omar.ramirez@ti.com> <1263240766-13000-7-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33387 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753987Ab0AKULc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 15:11:32 -0500
In-Reply-To: <1263240766-13000-7-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>

Ramirez Luna, Omar had written, on 01/11/2010 02:12 PM, the following:
[...]

> diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
> index 02def74..f52b7b8 100644
> --- a/drivers/dsp/bridge/pmgr/wcd.c
> +++ b/drivers/dsp/bridge/pmgr/wcd.c
[...]

> 
>  static inline void __cp_fm_usr(void *to, const void __user *from,
> @@ -273,13 +286,48 @@ static inline void __cp_to_usr(void __user *to, const void *from,
>  inline DSP_STATUS WCD_CallDevIOCtl(u32 cmd, union Trapped_Args *args,
>                                     u32 *result, void *pr_ctxt)
>  {
> -       if (cmd < ARRAY_SIZE(WCD_cmdTable)) {
> -               /* make the fxn call via the cmd table */
> -               *result = (*WCD_cmdTable[cmd].fxn) (args, pr_ctxt);
> -               return DSP_SOK;
> +       u32(*ioctl_cmd)(union Trapped_Args *args, void *pr_ctxt);
> +       int i;
> +
> +       if (_IOC_TYPE(cmd) != DB) {
> +               pr_err("%s: Incompatible dspbridge ioctl number\n", __func__);
> +               goto err;
>         }
> 
> -       return DSP_EINVALIDARG;
> +       /* Retrieve the fxn via the cmd table */
> +       i = cmd & DB_IOC_MASK;
> +       switch (cmd & DB_MODULE_MASK) {
> +       case DB_MGR:
> +               ioctl_cmd = mgr_cmd[i].fxn;
just realized we have a risk here. if i > sizeof(mgr_cmd), then we will 
not catch the out of range error.
[...]
-- 
Regards,
Nishanth Menon
