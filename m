From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v6 00/25] gpio/omap: driver cleanup and fixes
Date: Sun, 11 Sep 2011 09:37:14 +0100
Message-ID: <20110911083714.GA7187@n2100.arm.linux.org.uk>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<87ty8pz384.fsf@ti.com>
	<CAC83ZvKoSsGNMDoHNeCOZXk9mOZxcKjT_vMjnXGQn6F52YNDKg@mail.gmail.com>
	<CAC83ZvLN1ucD6R11ga3x7caaPgnEjYPYTehE7xfPf59XSjKYpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAC83ZvLN1ucD6R11ga3x7caaPgnEjYPYTehE7xfPf59XSjKYpQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, Sep 10, 2011 at 06:24:53AM +0530, DebBarma, Tarun Kanti wrote:
> [...]
> >> Please rebase onto that branch so these changes can be tested along with
> >> changes already queued for v3.2.
> > Ok.
> I am not able to git pull
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
> Looks like there is problem with git.kernel.org?

Yes - the main kernel.org server went down a week and a half ago due
to being cracked.  They notified the authorities and have been working
to analyze the intrusion, as well as verifying the considerable amount
of user data that they hold.

That wasn't too much of a problem (trees can be hosted elsewhere), but
it was followed a week later by the kernel.org DNS servers, which took
out access to things like git.kernel.org.  As mailing lists (such as
linux-omap) are hosted on vger.kernel.org, steps were taken to restore
some of the DNS so the mailing lists would continue working, but without
the master server the remainder of the DNS is still off-line.
