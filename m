From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: libbattery was Re: [RFC PATCH 5/5] power: generic-adc-battery:
 Add capacity handling
Date: Wed, 18 Oct 2017 17:47:18 +0200
Message-ID: <0C0901E1-23E8-4D04-B3A9-8314809A7A6B@goldelico.com>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
 <1501620926-22669-6-git-send-email-marek.belisko@open-nandra.com>
 <20170829101147.debhadzyfrxhkrvt@earth> <20170908113231.GJ18365@amd>
 <20171018122804.GA14376@amd>
 <61BFA8AF-657A-4AD7-A7AC-3E5DC3B7E83D@goldelico.com>
 <20171018132204.GD4394@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171018132204.GD4394@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: ivo.g.dimitrov.75@gmail.com, sakari.ailus@linux.intel.com, Marek Belisko <marek.belisko@open-nandra.com>, khilman@kernel.org, Marek Belisko <marek.belisko@gmail.com>, linux-pm@vger.kernel.org, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, martijn@brixit.nl, robh+dt@kernel.org, abcloriens@gmail.com, Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, clayton@craftyguy.net, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


> Am 18.10.2017 um 15:22 schrieb Tony Lindgren <tony@atomide.com>:
> 
> * H. Nikolaus Schaller <hns@goldelico.com> [171018 05:49]:
>>> Am 18.10.2017 um 14:28 schrieb Pavel Machek <pavel@ucw.cz>:
>>> 
>>> So I started something, it is at.
>>> 
>>> https://github.com/pavelmachek/libbattery
>>> 
>>> My battery on n900 is currently uncalibrated (and charging), still it
>>> gets some kind of estimation:
>>> 
>>> Battery -1 %
>>> Seconds -1
>>> State 1
>>> Voltage 3.88 V
>>> Battery 63 %
>>> 
>>> Of course, there's a lot more work to be done.
>> 
>> Nice start but not a solution to our problem.
>> 
>> Our problem is that people simply expect that for example https://packages.debian.org/wheezy/xfce/xfce4-battery-plugin
>> displays the battery percentage.
> 
> I think we could make things compatible with various battery apps by
> having libbattery write back the capacity percentage and time remaining
> to the kernel driver via sysfs or a dev entry. Then the kernel interface
> can just display the data to whatever apps.

Hm. That would be quite difficult to understand and maintain code.
Why not have the kernel driver do the simple calculations (they do
not need float) and provide the standard /sys/class/power attribute?

BR,
Nikolaus
