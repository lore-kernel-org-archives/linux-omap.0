From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 1/5] DSPBRIDGE: Remove unused typedefs.
Date: Mon, 21 Jun 2010 17:09:19 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4C78333B@dlee03.ent.ti.com>
References: <1277158034-21843-1-git-send-email-ernesto@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43393 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704Ab0FUWJZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 18:09:25 -0400
In-Reply-To: <1277158034-21843-1-git-send-email-ernesto@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramos Falcon, Ernesto" <ernesto@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>

> 
>  /* Macro's */
> -#define REG16(A)    (*(reg_uword16 *)(A))
> -
>  #define CLEAR_BIT(reg, mask)             (reg &= ~mask)
>  #define SET_BIT(reg, mask)               (reg |= mask)
> 

-- Another candidate for cleanup :)

> --
> 1.5.4.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
