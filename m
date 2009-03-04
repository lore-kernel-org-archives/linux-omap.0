From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [RFC 0/5] Sensor drivers for OMAP3430SDP and LDP camera
Date: Wed, 04 Mar 2009 13:43:03 +0800
Message-ID: <49AE14E7.2010709@windriver.com>
References: <A24693684029E5489D1D202277BE89442E1D921F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <A24693684029E5489D1D202277BE89442E1D921F@dlee02.ent.ti.com>
Sender: linux-media-owner@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "DongSoo(Nathaniel) Kim" <dongsoo.kim@gmail.com>, MiaoStanley <stanleymiao@hotmail.com>, "Nagalla, Hari" <hnagalla@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Lakhani, Amish" <amish@ti.com>, "Menon, Nishanth" <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Aguirre Rodriguez, Sergio Alberto wrote:
> This patch series depends on the following patches:
>
>  - "Add TWL4030 registers", posted by Tuukka Toivonen on March 2nd.
>  - "OMAP3 ISP and camera drivers" patch series, posted by Sakari Ailus on
>    March 3rd. (Please follow his instructions to pull from gitorious.org server)
>
> This has been tested with:
>  - SDP3430-VG5.0.1 with OMAP3430-ES3.1 daughter board upgrade.
>  - Camkit V3.0.1 with MT9P012 and OV3640 sensors
>  - LDP with OV3640 sensor
>
> Sergio Aguirre (5):
>   MT9P012: Add driver
>   DW9710: Add driver
>   OV3640: Add driver
>   
Hi, Sergio,

You forgot to send the 3rd patch, "OV3640: Add driver".

Stanley.

>   OMAP3430SDP: Add support for Camera Kit v3
>   LDP: Add support for built-in camera
>   

