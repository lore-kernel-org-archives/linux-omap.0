From: Jason Kridner <jkridner@gmail.com>
Subject: Re: Unifying cape overlays into boot .dtb for BeagleBoard.org boards
Date: Wed, 11 Jun 2014 01:11:41 -0400
Message-ID: <CA+T6QP=jqdKij3bg3qZKT8GAKTKP94XtDWR+rcJWnDME5ZNmUg@mail.gmail.com>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:64457 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbaFKFLm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jun 2014 01:11:42 -0400
In-Reply-To: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>, Robert Nelson <robertcnelson@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
Cc: OMAP List <linux-omap@vger.kernel.org>

Adding devicetree and linux-arm-kernel lists based on feedback on IRC...

On Tue, Jun 10, 2014 at 12:46 PM, Jason Kridner <jkridner@gmail.com> wrote:
> I'd like to discuss moving our current library of cape devicetree
> overlay sources into a single tree, including the boot .dtb files for
> BeagleBoard.org boards and moving towards enabling as much of the cape
> support into a single boot-time .dtb file with an approach similar to
> the cape-universal overlay
> (https://github.com/cdsteinkuehler/beaglebone-universal-io), but not
> in an overlay.
>
> First of all, I want to note this doesn't change my view on the
> importance of mainline support for devicetree overlays. They are still
> absolutely critical and highly useful, solving problems that cannot be
> solved through boot-time devicetrees. I'm simply looking for an
> approach that will complement the availability of overlays and provide
> the best user experience.
>
> Robert has been talking about the actions required to clean-up Debian
> Jessie support in another thread
> (https://groups.google.com/d/msg/beagleboard/2b8rArtfABY/A8d1JzmJa4IJ)
> and I suggested we should add a bit of a detour by cleaning up the
> cape support for the mainline kernel and switching away our primary
> process of supporting capes from using overlays to using a single
> devicetree file provided at boot. I promised a pull-request and hadn't
> gotten around to sending it until now (below). No architecture changes
> have been made in my pull-request, just bringing in the kernel
> devicetree source history. This suggestion is based on several
> assumptions, any number of which might be wrong.
>
> The assumptions (for which I'm looking for feedback/corrections):
> * The overlays pretty much all need to be compiled into the kernel if
> they are going to be loaded using kernel command-line arguments or
> /etc/capemgr for the majority of distros. While many cape devicetree
> use cases are perfectly happy with loading at run-time rather than
> boot-time, it seems there should be a mechanism for pushing cape
> support into the category of being available at boot-time across
> distributions.
> * The devicetree sources, including the primary boot .dts files, will
> eventually be removed from the kernel source tree. I'm not too sure if
> and when it'll really happen, but starting up a project to maintain
> the definitive beagleboard.org board devicetree files outside the
> kernel seems to make sense. Given the interdependency of the boot .dtb
> and the overlay .dtbo files, combining them into a single repository
> where every distribution can pick them up seems like a natural and
> obvious choice. There are of course some dependencies on kernel
> versions, but I believe most of those have settled out by now and we
> should be OK moving forward.
> * There seems to be little or no interest in my previous proposal to
> use cape EEPROMs to store the overlay fragments. Given some churn in
> the devicetree node definitions, it is likely this would have failed
> in bad ways anyway. It seems mostly reasonable to expect users to
> update their kernel and firmware to gain support for new add-on
> hardware and we mostly try to avoid regressions (with the seemingly
> ever-living exception of 3D graphics support), so I think I'm better
> aligned with the community to drop my older suggestion. Some people,
> including CircuitCo, are building capes without configuration EEPROMs
> now, so a different recommended mechanism seems like a requirement.
> * With the patches in our vendor 3.8 kernels and with all recent
> mainline kernels, performing userspace muxing operations has become
> easy again. It seems to be possible to turn on drivers not currently
> in use without an unacceptable level of bloat or conflict. This has
> been partially proven out using Charles' universal cape
> (https://github.com/cdsteinkuehler/beaglebone-universal-io), though I
> still have some concerns about conflicts. The result might be that
> there is still some number of overlays, but the approach of minimizing
> the overlays and instead relying on the existing loading/unloading
> mechanisms of the mainline drivers as much as possible feels right to
> me.
> * It will still be some time before devicetree overlay support is
> adopted in the mainline kernel. While I still see a strong need to
> have devicetree overlay support and CapeMgr in the mainline, the
> desire here is to optimize the user experience in the shortest term
> possible. Users get really confused by the errors that get generated
> by loading incorrect devicetree overlays and it is always nice when
> you can avoid confusing users.
>
> My suggestion is:
> * Maintain the source for .dtb and .dtbo files for all BeagleBoard.org
> boards at http://github.com/beagleboard/devicetree-source, overriding
> the sources in the mainline kernel when performing kernel builds. We
> can host pre-built .dtb and .dtbo files at a normailzed location
> outside the source repository for those that don't want to perform the
> builds, since I don't believe the binary format is changing any time
> soon other than the overlay support we utilize. Any patches accepted
> into mainline as long as these files still exist there as well should
> be merged to try to keep these in-line as long as possible,
> anticipating eventual removal from mainline.
> * Have cape makers submit pull requests to have their cape enabled in
> the single boot-time devicetree overlay for each board they support.
> The base drivers should be enabled at the earliest point where they
> don't cause a conflict, minimizing what gets put into their overlays.
> The final mux configuration and other points of conflict should be
> kept in a board-specific overlay to make that configuration available
> at boot. If the cape is disabled on the kernel command-line, the
> kernel doesn't include CapeMgr support, or the board doesn't include a
> configuration EEPROM, users would still have the ability to perform
> run-time userspace mux configuration without CapeMgr unless
> conflicting drivers need to be loaded.
>
> Alternatively, if we don't think this is where things belong, perhaps
> we could try to move all of this into the u-boot sources, though
> people using other bootloaders might not find this the most useful
> approach.
>
> The pull request for http://github.com/beagleboard/devicetree-source:
>
> The following changes since commit a524bf5d5e173795ce4cb214280f304588b1d78d:
>
>   capes: add BB-VIEW-LCD4-01-00A0 & BB-VIEW-LCD7-01-00A0 (2014-05-29
> 15:59:31 -0500)
>
> are available in the git repository at:
>
>   git@github.com:jadonk/cape-firmware master
>
> for you to fetch changes up to 9de20db80056b72d6e1f61b68447ba8f2d12cf9c:
>
>   Beagle DTS: remove deleted files from Makefile (2014-06-02 12:35:28 -0400)
>
> ----------------------------------------------------------------
>
> [...] Too many changes to list bringing in kernel history.
