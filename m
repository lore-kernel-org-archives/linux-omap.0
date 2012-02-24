From: Joerg Roedel <Joerg.Roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 2/2] iommu/omap: fix NULL pointer dereference
Date: Fri, 24 Feb 2012 14:16:38 +0100
Message-ID: <20120224131638.GH2454@amd.com>
References: <1329902086-13868-1-git-send-email-ohad@wizery.com>
	<20120223161109.GB2454@amd.com>
	<CAK=WgbYufgQY-O_MBcXc3aE23sx+r5ZQLS4h_bLUh6DKpLVqAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAK=WgbYufgQY-O_MBcXc3aE23sx+r5ZQLS4h_bLUh6DKpLVqAg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Hiroshi DOYU <Hiroshi.DOYU-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 23, 2012 at 06:16:59PM +0200, Ohad Ben-Cohen wrote:
> On Thu, Feb 23, 2012 at 6:11 PM, Joerg Roedel <Joerg.Roedel-5C7GfCeVMHo@public.gmane.org> wrote:
> > I guess these patches are 3.3 material?
> 
> Yes.
> 
> > How about tagging them for stable too?
> 
> Good point. But it's only relevant for this 2nd patch (the NULL
> pointer dereference fix), as the first one is a 3.3 regression. Let me
> know if you want me to resend the 2nd one with the stable tag.

Applied both and added stable-tag to the second patch. I'll send the
pull-request when you guys also send me the correct fix for the
outstanding initialization order issue on OMAP.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
