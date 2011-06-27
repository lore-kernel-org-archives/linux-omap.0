From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Mon, 27 Jun 2011 08:40:46 +0100
Message-ID: <20110627074046.GA1777@n2100.arm.linux.org.uk>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
	<20110624140142.GM9449@n2100.arm.linux.org.uk>
	<B85A65D85D7EB246BE421B3FB0FBB593024D6C2EF2@dbde02.ent.ti.com>
	<20110624141402.GN9449@n2100.arm.linux.org.uk>
	<20110624151201.GO9449@n2100.arm.linux.org.uk>
	<4E04DBF8.1050401@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D6C2FE3@dbde02.ent.ti.com>
	<20110625190922.GA7736@n2100.arm.linux.org.uk>
	<B85A65D85D7EB246BE421B3FB0FBB593024D6C3103@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D6C3103@dbde02.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 27, 2011 at 10:24:43AM +0530, Premi, Sanjeev wrote:
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> > Sent: Sunday, June 26, 2011 12:39 AM
> > To: Premi, Sanjeev
> > Cc: Shilimkar, Santosh; linux-omap@vger.kernel.org; 
> > linux-arm-kernel@lists.infradead.org; Hilman, Kevin
> > Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix 
> > loops_per_jiffy calculation
> > 
> > On Sun, Jun 26, 2011 at 12:23:31AM +0530, Premi, Sanjeev wrote:
> > > [sp] I thought we were solving a problem - but this makes it
> > >      look like race for addding sign-offs - which I am not
> > >      interested in.
> > 
> > No, it's called packaging the patch up and getting it ready, 
> > putting it
> > out on the list for people to test and provide Tested-by's, acked-by's
> > etc.
> 
> [sp] Agree.
> 
> > 
> > Would you rather people sat on fixes doing nothing with them for a
> > month instead, watching broken -rc after broken -rc going by?
> >
> [sp] The original patch was just few hours ago... not month(s).

I fail to see what the problem is you're referring to.
