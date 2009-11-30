From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] mfd: twl4030: Driver for twl4030 madc module
Date: Mon, 30 Nov 2009 18:52:21 +0100
Message-ID: <20091130185221.1215213f@hyperion.delvare>
References: <1259146071-2372-1-git-send-email-amit.kucheria@verdurent.com>
	<20091127193636.GA16866@sortiz.org>
	<37786d4b0911300558i984d2bdj9b0c5617503c1950@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753111AbZK3RwT@vger.kernel.org>
In-Reply-To: <37786d4b0911300558i984d2bdj9b0c5617503c1950@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, List Linux Kernel <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, Mikko Ylinen <mikko.k.ylinen@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 30 Nov 2009 15:58:39 +0200, Amit Kucheria wrote:
> On Fri, Nov 27, 2009 at 9:36 PM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> > By the way, have you considered moving this one to drivers/hwmon ?
> 
> I haven't. I moved it from i2c/chips/ to the most obvious place I
> could think of - drivers/mfd. But wasn't this the point of mfd - that
> various subcomponents drivers could live there instead of being
> scattered across the driver tree?
> 
> Adding Jean to CC, if he would consider taking this driver in drivers/hwmon..

In its current form, no. This driver doesn't implement the sysfs
interface described in Documentation/hwmon/sysfs-interface. It doesn't
even register a hwmon class device. So it doesn't belong in
drivers/hwmon.

-- 
Jean Delvare
