From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 0/9] ARM: OMAP3+: pwrdm changes for usecounting
Date: Thu, 31 May 2012 16:28:53 +0300
Message-ID: <1338470942-20185-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

Refreshed the patches against latest mainline kernel, and did some
updates mainly proposed by Nishanth Menon <nm@ti.com>. Changes compared
to previous version:

patch 1:
 - added check against null pointer

patch 2:
 - added BUG_ON in case clkdm / pwrdm usecount goes negative

patch 3:
 - added BUG_ON in case voltdm usecount goes negative
 - removed smartreflex enable / disable from voltdm code (this should
   be added in a separate patch once this is deemed safe)
 - changed target_state from int to u8

patch 4:
 - changed idle loop count initializations to happen synchronously with
   PM init, this avoids potential trouble in a case where a CPU would
   enter idle before usecount init for the idle has been done
 - added functions pwrdm_cpu_wakeup + pwrdm_cpu_idle to be called from idle
   cycle

patch 7:
 - changed flag name from CLKDM_NO_MANUAL_TRANS to CLKDM_SKIP_MANUAL_TRANS

patch 9:
 - added as new patch, would appreciate testing for this one!

Tested on omap3 beagle + boot tested on omap4460 panda es. Previous version
of this set had some issues with omap3430 devices (n900), which might have
been caused by improper clock handling or security on these devices. I can't
test these patches myself on n900, so if someone could do this that would
be extra nice.

git tree also available:
tree: git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
branch: mainline-3.4-pwrdm-changes-v3

-Tero
