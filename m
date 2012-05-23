From: Joerg Roedel <Joerg.Roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] iommu/core: pass a user-provided token to fault handlers
Date: Wed, 23 May 2012 12:04:54 +0200
Message-ID: <20120523100454.GI2604@amd.com>
References: <1337620805-30217-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1337620805-30217-1-git-send-email-ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Fernando Guzman Lugo <fernando.lugo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, May 21, 2012 at 08:20:05PM +0300, Ohad Ben-Cohen wrote:
> Sometimes a single IOMMU user may have to deal with several
> different IOMMU devices (e.g. remoteproc).
> 
> When an IOMMU fault happens, such users have to regain their
> context in order to deal with the fault.
> 
> Users can't use the private fields of neither the iommu_domain nor
> the IOMMU device, because those are already used by the IOMMU core
> and low level driver (respectively).
> 
> This patch just simply allows users to pass a private token (most
> notably their own context pointer) to iommu_set_fault_handler(),
> and then makes sure it is provided back to the users whenever
> an IOMMU fault happens.
> 
> The patch also adopts remoteproc to the new fault handling
> interface, but the real functionality using this (recovery of
> remote processors) will only be added later in a subsequent patch
> set.
> 
> Cc: Fernando Guzman Lugo <fernando.lugo-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>

Applied, thanks.


-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
