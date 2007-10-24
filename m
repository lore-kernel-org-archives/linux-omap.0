From: "arun c" <arun.edarath@gmail.com>
Subject: omap GPIO programming
Date: Wed, 24 Oct 2007 14:35:40 +0530
Message-ID: <c656a4d20710240205h37ed0e13m2484fba021ecd889@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi all,

I want to use GPIOs 87,142,140 in omap2430. I am using a custom kernel.
i wrote a kernel modules with the following API to use the 3 pins

1)omap_request_gpio
2)omap_set_gpio_direction
3)omap_set_gpio_dataout
4)omap_free_gpio

But i could able to write data only to GPIO 140. other GPIOs are not showing
any voltage changes to writing 0 or 1 to them.

Whether i have to set pin muxing or use any other kernel api to use
the GPIOS 142 and 87?? please help me.

Regards,
Arun
