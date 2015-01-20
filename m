From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH v5 0/4] ARM: OMAP2+: AM33XX: Add suspend-resume support
Date: Tue, 20 Jan 2015 13:22:12 -0800
Message-ID: <20150120212212.GN7718@atomide.com>
References: <cover.1417038624.git.d-gerlach@ti.com>
 <20150120180347.GJ7718@atomide.com> <54BEBB4D.90802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <54BEBB4D.90802@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Benoit Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach@ti.com> [150120 12:35]:
> Tony,
> On 01/20/2015 12:03 PM, Tony Lindgren wrote:
> > * Dave Gerlach <d-gerlach@ti.com> [141126 13:54]:
> >> Hi,
> >> This series is v5 of the series to add suspend/resume support for Texas
> >> Instruments AM335x SoC. It has gone through a rather major overhaul
> >> since the last version and because of that has been split into multiple
> >> different sets of patches, on which this series depends. Previous discussion
> >> that influenced there changes can be found here [1]. This series depends on
> >> generic sram exec mapping patch here [2], emif series here [3],
> >> and wkup_m3_ipc series here [4]. I have pushed a branch containing the patches
> >> from ALL required series here [5] for testing or a view of the high level
> >> flow of the entire series.
> >>
> >> The largest change with this revision is the introduction of a
> >> wkup_m3_ipc driver which handles all communication with the Cortex M3
> >> present on am335x for handling low power tasks. Previously this was
> >> handled in the wkup_m3_rproc driver (also sent in an earlier series)
> >> but that driver is now only responsible for booting the wkup_m3. The
> >> wkup_m3_ipc driver exposes an API with all required PM functionality
> >> needed by the PM code introduced by this series, so the PM code has
> >> shrunk considerably.
> >>
> >> Another major change is that the EMIF code previously present in the
> >> sleep33xx asm code and pm33xx code for save and restore of EMIF context
> >> and entry into low power mode has all been moved in to a separate EMIF
> >> driver, further reducing the size of the PM code. Because of this, moving
> >> the emif header defines into include/linux/ti_emif.h is no longer necessary.
> >>
> >> Other changes include clean up of the timer suspend/resume handlers, now
> >> look up hwmod in init and use that handle along with renaming to
> >> *_idle/*_unidle to avoid confusion with true suspend handlers. 
> >>
> >> Suspend support requires:
> >> CONFIG_TI_EMIF_SRAM
> >> CONFIG_WKUP_M3_RPROC
> >> CONFIG_WKUP_M3_IPC
> >>
> >> And also requires AM335x USB support to be enabled to work for multiple
> >> cycles. If you want to load firmware from rootfs in /lib/firmware you now
> >> must also select CONFIG_FW_LOADER_USER_HELPER_FALLBACK.
> >>
> >> This code works with version 0x189 of the CM3 firmware found here [6] on
> >> the next branch, /bin/am335x-pm-firmware.elf.
> > 
> > Dave, does this series have dependencies to the other patches? Can some
> > parts of this already be applied without breaking anything?
> > 
> 
> The only patch with no dependencies is patch 1 (ARM: OMAP2+: timer: Add
> suspend-resume callbacks for clkevent device). It's ready to be applied, I just
> applied to v3.19-rc5 and built and booted on am335x-evm with no issue just to be
> sure. It won't actually do anything until suspend is completely implemented.

OK thanks for checking, best to wait until it's usable then.

Regards,

Tony
