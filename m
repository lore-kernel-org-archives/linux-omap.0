From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: Re: [REVIEW PATCH 00/14] OMAP3 camera + ISP + MT9P012 sensor driver
 v2
Date: Mon, 19 Jan 2009 12:20:12 +0200
Message-ID: <497453DC.6020102@nokia.com>
References: <A24693684029E5489D1D202277BE894416429F96@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <A24693684029E5489D1D202277BE894416429F96@dlee02.ent.ti.com>
Sender: linux-media-owner@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, "Nagalla, Hari" <hnagalla@ti.com>
List-Id: linux-omap@vger.kernel.org

Aguirre Rodriguez, Sergio Alberto wrote:
> Hi,
> 
> I'm sending the following patchset for review to the relevant lists (linux-omap, v4l, linux-media).
> 
> Includes:
>  - Omap3 camera core + ISP drivers.
>  - MT9P012 sensor driver (adapted to 3430SDP)
>  - DW9710 lens driver (adapted to work with MT9P012 for SDP)
>  - Necessary v4l2-int-device changes to make above drivers work
>  - Redefine OMAP3 ISP platform device.
>  - Review comments fixed from: (Thanks a lot for their time and help)
>    - Hans Verkuil
>    - Tony Lindgreen
>    - Felipe Balbi
>    - Vaibhav Hiremath
>    - David Brownell

Hi Sergio,

We should try to figure out how we could synchronise our version of the 
ISP and camera ASAP before making any more changes... I wouldn't want to 
start posting a competing version. ;-)

-- 
Sakari Ailus
sakari.ailus@nokia.com
