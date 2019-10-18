From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/2] OMAP IOMMU fixes to go with 5.4 OMAP IOMMU changes
Date: Fri, 18 Oct 2019 08:41:58 -0700
Message-ID: <20191018154158.GQ5610@atomide.com>
References: <20190827001452.31930-1-s-anna@ti.com>
	<68474455-c997-a40e-74c4-ea3e0faa6c24@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <68474455-c997-a40e-74c4-ea3e0faa6c24-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [191017 23:00]:
> Hi Tony,
> 
> On 8/26/19 7:14 PM, Suman Anna wrote:
> > Hi Tony,
> > 
> > The following 2 patches need to go along with the recent "iommu/omap: misc
> > fixes" series [1] that is currently staged [2] for a 5.4 merge and available
> > in linux-next. That series added runtime pm callbacks in preparation for
> > the ti-sysc migration, but without adding the necessary platform data
> > callbacks for the existing functional MMUs on OMAP3, OMAP4 and OMAP5 SoCs.
> > These 2 patches add the same to maintain the functionality (l3_noc errors
> > are the visible symptom while enabling the MMUs without these patches).
> > 
> > OMAP4 and OMAP5 would also need another set of fixes related to the
> > breakage caused by the switch to clkctrl clocks as seen in [3].
> > 
> > These patches do have a dependency on the staged patches, so either you
> > submit a pull-request towards 5.4-rc2 using 5.4-rc1 baseline, or let
> > Joerg pick these through the arm/omap IOMMU branch for 5.4-rc1 itself.
> > 
> > Sakari/Laurent,
> > Appreciate it if you can check the OMAP3 ISP functionality on latest
> > linux-next with the second patch. I have verified the ISP MMU programming
> > only through an unit-test.
> > 
> > Tero,
> > I will be submitting another patch against OMAP IOMMU driver to skip the
> > pdata callbacks for ti-sysc in the next couple of days.
> > 
> > regards
> > Suman
> > 
> > [1] https://lore.kernel.org/linux-iommu/20190809153730.GF12930-zLv9SwRftAIdnm+yROfE0A@public.gmane.org/T/#mec99f8e8ed351689f4fcc76f4f000f9144a02b51
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/log/?h=arm/omap
> > [3] https://patchwork.kernel.org/patch/11082125/#22829477
> > 
> > Suman Anna (2):
> >   ARM: OMAP2+: Plug in device_enable/idle ops for IOMMUs
> >   ARM: OMAP2+: Add pdata for OMAP3 ISP IOMMU
> 
> Can you please pick these patches up for 5.4-rc cycle? The OMAP IOMMU
> changes that went in for 5.4-rc1 need the pdata to be plugged in.

Oh OK. Sorry for missing these, I untagged them earlier as they
produced kbuilder test failures as the dependencies were
missing earlier.

Applying both into fixes.

Regards,

Tony
