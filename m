From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/omap: fix NULL pointer dereference
Date: Wed, 22 Feb 2012 09:17:52 +0000
Message-ID: <20120222091752.GG22675@n2100.arm.linux.org.uk>
References: <1329900772-9306-1-git-send-email-ohad@wizery.com>
	<1329900772-9306-2-git-send-email-ohad@wizery.com>
	<20120222085623.GF22675@n2100.arm.linux.org.uk>
	<CAK=Wgba1CfpZpDqN3fruL-Ax_a_DwGuB=92pq4Ng3cSUGL8e2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAK=Wgba1CfpZpDqN3fruL-Ax_a_DwGuB=92pq4Ng3cSUGL8e2Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Hiroshi DOYU <Hiroshi.DOYU-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 22, 2012 at 11:10:38AM +0200, Ohad Ben-Cohen wrote:
> On Wed, Feb 22, 2012 at 10:56 AM, Russell King - ARM Linux
> <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> > There's something else which needs fixing here - the return code. =A0If
> > omap_find_iovm_area() returns an error code that needs propagating.
> > Otherwise it might as well just return NULL for all errors.
> =

> Seems like it does just return NULL for all errors, so a cleaner fix
> can probably just be s/IS_ERR(area)/!area/.
> =

> I'll submit it, but Joerg, if you feel this is becoming a "cleanup",
> feel free to take the first version.

That sounds more like a bug fix than a cleanup to me.
