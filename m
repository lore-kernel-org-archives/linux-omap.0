From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] CPUidle: always return with interrupts
	enabled
Date: Fri, 16 Oct 2009 14:11:04 -0700
Message-ID: <20091016141104.d794f2c4.akpm@linux-foundation.org>
References: <1254332153-23493-1-git-send-email-khilman@deeprootsystems.com>
	<200909302321.33088.rjw@sisk.pl>
	<20091006133456.5177a32a.akpm@linux-foundation.org>
	<20091016162504.GC1391@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091016162504.GC1391@deprecation.cyrius.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 16 Oct 2009 17:25:04 +0100
Martin Michlmayr <tbm@cyrius.com> wrote:

> * Andrew Morton <akpm@linux-foundation.org> [2009-10-06 13:34]:
> > Rigor mortis is setting in on this one.
> 
> > The patch seems correct to me.
> 
> Can someone put this patch in now?  The problem has also been reported
> on Marvell's Kirkwood platform (ARM) by a number of users and the
> patch fixes it.
> 
> Tested-by: Martin Michlmayr <tbm@cyrius.com>

I have it in my for-2.6.32 queue.

> Please CC stable when you commit the patch since it also needs to go
> in for 2.6.31.

hm, I didn't know that.  So noted, thanks.
