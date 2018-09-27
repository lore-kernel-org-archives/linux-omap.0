From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Update am437x and am335x dts to probe with ti-sysc
Date: Thu, 27 Sep 2018 12:38:57 -0700
Message-ID: <20180927193857.GE5662@atomide.com>
References: <20180925000545.22931-1-tony@atomide.com>
 <e9afe736-c2f0-6182-afd0-08279e09a35e@ti.com>
 <20180925144021.GN5662@atomide.com>
 <20180925175537.GQ5662@atomide.com>
 <d98aa7c1-5131-34c5-51e5-c7ef57cbc31e@ti.com>
 <20180926155911.GT5662@atomide.com>
 <20180926162303.GU5662@atomide.com>
 <cfc3f1db-9468-ed92-a673-882b51b4dec8@ti.com>
 <20180926233111.GY5662@atomide.com>
 <033a9b5f-c7cb-f2dd-31b4-3f178d74b79b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <033a9b5f-c7cb-f2dd-31b4-3f178d74b79b@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [180927 19:16]:
> On 09/26/2018 06:31 PM, Tony Lindgren wrote:
> > 
> > OK. So looks like the other i2c bus drivers have already solved it
> > with simply SET_NOIRQ_SYSTEM_SLEEP_PM_OPS which is along the lines
> > you're suggesting.
> > 
> > The following works for me, does it look OK to you?
> 
> it looks good, just curious if it will work both ti-sysc legacy/nonlegacy modes.

OK, yes it seems to pass my artificial test case without ti-sysc
dts changes, see below. So I just sent the i2c-omap patch as:

"[PATCH] i2c: omap: Use noirq system sleep pm ops to idle device for suspend"

Regards,

Tony

8< -----------
[   70.509713] PM: suspend entry (deep)
[   70.509739] PM: Syncing filesystems ... done.
[   70.516785] Freezing user space processes ... (elapsed 0.001 seconds) done.
[   70.518746] OOM killer disabled.
[   70.518756] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   70.520393] Suspending console(s) (use no_console_suspend to debug)
[   70.532983] wlan0: deauthenticating from 42:04:7a:03:0b:78 by local choice (Reason: 3=DEAUTH_LEAVING)
[   70.589742] wlcore: down
[   70.590435] wlcore: down
[   70.672208] Disabling non-boot CPUs ...
[   70.672237] pm33xx pm33xx: PM: Successfully put all powerdomains to target state
[   70.694047] net eth0: initializing cpsw version 1.15 (0)
[   70.792216] Micrel KSZ9031 Gigabit PHY 4a101000.mdio:04: attached PHY driver [Micrel KSZ9031 Gigabit PHY] (mii_bus:p)
[   70.795548] net eth1: initializing cpsw version 1.15 (0)
[   70.902204] Micrel KSZ9031 Gigabit PHY 4a101000.mdio:05: attached PHY driver [Micrel KSZ9031 Gigabit PHY] (mii_bus:p)
[   71.007103] usb usb1: root hub lost power or was reset
[   71.007121] usb usb2: root hub lost power or was reset
[   71.322414] wlcore: PHY firmware version: Rev 8.2.0.0.236
[   71.417839] wlcore: firmware booted (Rev 8.9.0.0.69)
[   71.444787] OOM killer enabled.
[   71.444799] Restarting tasks ... done.
[   71.461113] PM: suspend exit
