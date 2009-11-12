From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 1/1]: Thaws refrigerated bdi flusher threads
	before	invoking kthread_stop on them
Date: Thu, 12 Nov 2009 13:05:47 +0100
Message-ID: <20091112120546.GI8742@kernel.dk>
References: <1257928216.15415.57.camel@boson> <200911111230.58479.rjw@sisk.pl>
	<20091111193719.GR8742@kernel.dk> <200911112141.12437.rjw@sisk.pl>
	<1258026726.2341.1.camel@boson>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1258026726.2341.1.camel@boson>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Romit Dasgupta <romit@ti.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 12 2009, Romit Dasgupta wrote:
> Resubmitting after incorporationg the suggestions:
> > 
> > Romit, please rework as suggested by Jens and resubmit.
> 
> Unfreezes the bdi flusher task when the said task needs to exit.

Thanks, this looks more palatable. I will merge it and make sure it goes
upstream soon.

-- 
Jens Axboe
