From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [REVIEW PATCH 04/14] OMAP: CAM: Add ISP user header and register
	defs
Date: Tue, 13 Jan 2009 17:02:31 +0530
Message-ID: <5d5443650901130332l748240bfi7697dc446b92d3c5@mail.gmail.com>
References: <A24693684029E5489D1D202277BE894416429F9A@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <A24693684029E5489D1D202277BE894416429F9A@dlee02.ent.ti.com>
Sender: linux-media-owner@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>, Sakari Ailus <sakari.ailus@nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, "Nagalla, Hari" <hnagalla@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Sergio,

> +++ b/arch/arm/plat-omap/include/mach/isp_user.h
> @@ -0,0 +1,668 @@
> +/*
> + * include/asm-arm/arch-omap/isp_user.h
> + *

Path doesn't match. Better remove paths from all files, as they keep
changing, and maintaining them is hard.


-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
