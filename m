From: Artem Bityutskiy <dedekind@yandex.ru>
Subject: Re: [PATCH 1/4] [OMAPZOOM] [UPDATE]DSPBRIDGE: Memory lock for DMM.
Date: Wed, 01 Apr 2009 10:25:56 +0300
Message-ID: <49D31704.6020105@yandex.ru>
References: <496565EC904933469F292DDA3F1663E60287EF28E7@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:36454 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbZDAH0W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2009 03:26:22 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E60287EF28E7@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Guzman Lugo, Fernando wrote:
> +		patemp =3D pa;
> +		while (temp++ < num4KEntries) {
> +			/* FIXME: This is a hack to avoid getting pages for
> +			 *  video overlay		*/
> +			if (pfn_valid(__phys_to_pfn(patemp))) {
> +				pg =3D phys_to_page(patemp);
> +				get_page(pg);
> +				if (page_count(pg) <=3D 1) {
> +					printk(KERN_EMERG "DSPBRIDGE:MAP  "
> +						"function: COUNT 0 FOR PA "
> +						"0x%x\n", patemp);
> +					printk(KERN_EMERG "Bad page state"
> +						"in process '%s'\n"
> +						"page:%p flags:0x%0*lx "
> +						"mapping:%p mapcount:%d "
> +						"count:%d\n"
> +						"Trying to fix it up, but "
> +						"a reboot is needed\n"
> +						"Backtrace:\n",
> +						current->comm, pg,
> +						(int)(2*sizeof(unsigned long)),
> +						(unsigned long)pg->flags,
> +						pg->mapping, page_mapcount(pg),
> +						page_count(pg));
> +					dump_stack();
> +					BUG_ON(1);
> +				}
> +			}

Sorry for repeating myself, I just thought I have a good
suggestion. You could try the Obfuscated C code contest
and win some money with this code:

http://www.ioccc.org

:-)

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
