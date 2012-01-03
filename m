From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/7] amp/remoteproc: add debugfs entries
Date: Tue, 3 Jan 2012 16:36:44 -0700
Message-ID: <20120103233644.GD2492@ponder.secretlab.ca>
References: <1319536106-25802-1-git-send-email-ohad@wizery.com>
 <1319536106-25802-3-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1319536106-25802-3-git-send-email-ohad@wizery.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Brian Swetland <swetland@google.com>, Rusty Russell <rusty@rustcorp.com.au>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 25, 2011 at 11:48:21AM +0200, Ohad Ben-Cohen wrote:
> Expose several remote processor properties (name, state, trace buffer)
> that are helpful for debugging.
> 
> This part is extracted to a separate patch just to keep the review load
> down.
> 
> Designed with Brian Swetland <swetland@google.com>.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  drivers/amp/remoteproc/Makefile             |    1 +
>  drivers/amp/remoteproc/remoteproc_debugfs.c |  182 +++++++++++++++++++++++++++
>  2 files changed, 183 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/amp/remoteproc/remoteproc_debugfs.c
