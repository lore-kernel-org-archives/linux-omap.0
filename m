From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: Re: [PATCH] Add OMAP2 camera driver
Date: Mon, 08 Dec 2008 14:05:26 +0200
Message-ID: <493D0D86.3080108@nokia.com>
References: <A24693684029E5489D1D202277BE894415C11947@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <A24693684029E5489D1D202277BE894415C11947@dlee02.ent.ti.com>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: "ext Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

ext Aguirre Rodriguez, Sergio Alberto wrote:
> Although the end result of making OMAP3 cam driver independent from
> ISP doesn't make much sense to me, as in OMAP3 the ISP is needed even
> for the minimal handling required for receiving data from the sensors
> that the camera driver supports. (Minimal datapath is CCP2->SDRAM or
> CSI2->SDRAM, and that requires ISP MMU and the corresponding
> receivers, which are considered part of the ISP)

The benefit is that this driver could have use beyond the OMAP 3 
platform as it could be used with other ISPs. It's not dependent on any 
particular sensors either.

-- 
Sakari Ailus
sakari.ailus@nokia.com

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
