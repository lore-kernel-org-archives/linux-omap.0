From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC PATCH 6/6] hwmon: OMAP4: On die temperature sensor driver
Date: Thu, 11 Aug 2011 16:37:19 -0500
Message-ID: <4E444B8F.9060908@ti.com>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
	<1312979122-5896-7-git-send-email-j-keerthy@ti.com>
	<20110810124629.GJ12882@legolas.emea.dhcp.ti.com>
	<CAJ6a13Z=u=exWUHLotw8jpHMv-hKpE+fvg_1hq7=gtMiuJKxOA@mail.gmail.com>
	<20110811103658.GG27742@legolas.emea.dhcp.ti.com>
	<CAJ6a13bxg8po-Csc10LsFH-oES4YOKkqFoTm3kG4XzS=b2boMw@mail.gmail.com>
	<20110811141248.GK28500@legolas.emea.dhcp.ti.com>
	<CAJ6a13b7qu3K4YJPTYych_NQxLuuUxZOQg6PPC_=XA+qiwn2RA@mail.gmail.com>
	<20110811185408.GB15970@legolas.emea.dhcp.ti.com>
	<20110811185558.GC15970@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110811185558.GC15970@legolas.emea.dhcp.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: Russell King <linux@arm.linux.org.uk>, b-cousson@ti.com, Tony Lindgren <tony@atomide.com>, "J,
	KEERTHY" <j-keerthy@ti.com>, rnayak@ti.com, lm-sensors@lm-sensors.org, khali@linux-fr.org, vishwanath.bs@ti.com, linux-omap@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, guenter.roeck@ericsson.com
List-Id: linux-omap@vger.kernel.org

On 08/11/2011 01:55 PM, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Aug 11, 2011 at 09:54:09PM +0300, Felipe Balbi wrote:
>>>> you need some other way to handle this. Why do you need to manually set
>>>> the rate rather than having hwmod handle this for you ?
>>>>
>>>> your argument that "it's a one time setting" is not enough to have this
>>>> in the driver. Drivers should not care about clocks anymore, this should
>>>> have been done on another layer.
>>>
>>> Hwmod will have no idea on the rate required.
>>
>> does the rate need to change ? Also, I have not mentioned hwmod anytime
> 
> i did mention hwmod, nevermind that part. Still I'm not sure where is
> the right place to handle this.
> 

Aren't the omap_device_pm_latency callbacks the right place to do it?

e.g. in the following snippet from mach-omap2/temp_sensor_device.c

+static struct omap_device_pm_latency omap_temp_sensor_latency[] = {
+	{
+	 .deactivate_func = omap_device_idle_hwmods,
+	 .activate_func = omap_device_enable_hwmods,
+	 .flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	}
+};

instead of directly pointing activate_func to omap_device_enable_hwmods,
it could point to a function that sets the required clock rate and then
enables the hwmod.


regards,
-roger
