From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/7] Introducing a generic AMP framework
Date: Wed, 26 Oct 2011 14:30:50 +1030
Message-ID: <874nywpfkd.fsf@rustcorp.com.au>
References: <1319536106-25802-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1319536106-25802-1-git-send-email-ohad@wizery.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Brian Swetland <swetland@google.com>, Grant Likely <grant.likely@secretlab.ca>, akpm@linux-foundation.org
List-Id: linux-omap@vger.kernel.org

On Tue, 25 Oct 2011 11:48:19 +0200, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Modern SoCs typically employ a central symmetric multiprocessing (SMP)
> application processor running Linux, with several other asymmetric
> multiprocessing (AMP) heterogeneous processors running different instances
> of operating system, whether Linux or any other flavor of real-time OS.

OK, I'm not even sure who this should go through, but no objections here
but one:

virtio-spec.txt is a derived document, so I'd prefer that patch to go
through me so I can patch the (LyX) master copy.

Thanks!
Rusty.
