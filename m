From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH RESEND] omap : nand : fix subpage ecc issue
 with prefetch
Date: Wed, 11 May 2011 07:54:31 -0700
Message-ID: <20110511145431.GA18317@kroah.com>
References: <1305123897-11371-1-git-send-email-kishore.kadiyala@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <stable-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1305123897-11371-1-git-send-email-kishore.kadiyala@ti.com>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/stable>,
	<mailto:stable-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/mailman/private/stable/>
List-Post: <mailto:stable@linux.kernel.org>
List-Help: <mailto:stable-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/stable>,
	<mailto:stable-request@linux.kernel.org?subject=subscribe>
Sender: stable-bounces@linux.kernel.org
Errors-To: stable-bounces@linux.kernel.org
To: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: Vimal Singh <vimal.newwork@gmail.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, stable@kernel.org, dedekind1@gmail.com
List-Id: linux-omap@vger.kernel.org

On Wed, May 11, 2011 at 07:54:57PM +0530, Kishore Kadiyala wrote:
> When reading/writing a subpage (When HW ECC is not available/enabled)
> for number of bytes not aligned to 4, the mis-aligned bytes are handled
> first (by cpu copy method) before enabling the Prefetch engine to/from
> 'p'(start of buffer 'buf'). Then it reads/writes rest of the bytes with
> the help of Prefetch engine, if available, or again using cpu copy method.
> Currently, reading/writing of rest of bytes, is not done correctly since
> its trying to read/write again to/from begining of buffer 'buf',
> overwriting the mis-aligned bytes.
> 
> Read & write using prefetch engine got broken in commit '2c01946c'.
> We never hit a scenario of not getting 'gpmc_prefetch_enable' call
> success. So, problem did not get caught up.
> 
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> Signed-off-by: Vimal Singh <vimal.newwork@gmail.com>
> Reported-by: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
> ---
>  drivers/mtd/nand/omap2.c |   12 +++++-------
>  1 files changed, 5 insertions(+), 7 deletions(-)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>

_______________________________________________
stable mailing list
stable@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/stable
