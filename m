From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Fri, 24 Jun 2011 15:14:02 +0100
Message-ID: <20110624141402.GN9449@n2100.arm.linux.org.uk>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
	<20110624140142.GM9449@n2100.arm.linux.org.uk>
	<B85A65D85D7EB246BE421B3FB0FBB593024D6C2EF2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2EF2@dbde02.ent.ti.com>
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
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 24, 2011 at 07:39:41PM +0530, Premi, Sanjeev wrote:
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> > Sent: Friday, June 24, 2011 7:32 PM
> > To: Premi, Sanjeev
> > Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix 
> > loops_per_jiffy calculation
> 
> [snip]...[snip]
> 
> > > 
> > > +#ifdef CONFIG_SMP
> > > +	/* Adjust jiffies before transition */
> > > +	for_each_cpu(i, policy->cpus) {
> > > +		unsigned long lpj = per_cpu(cpu_data, 
> > i).loops_per_jiffy;
> > > +
> > > +		per_cpu(cpu_data, i).loops_per_jiffy = 
> > cpufreq_scale(lpj,
> > > +							freqs.old,
> > > +							freqs.new);
> > > +	}
> > > +#endif
> > > +
> > 
> > You didn't listen to what I told you.  It'll be quicker for 
> > me to write
> > this patch myself if you send me the *original* file.
> > 
> 
> Russell,
> 
> The function adjust_jiffies() is no-op for CONFIG_SMP - but it
> is not the case with cpufreq_scale().
> 
> So, when CONFIG_SMP is defined, then loops_per_jiffy would be
> calculated for both UP and SMP processors.
> 
> Did I miss something else?

Yes you have, and you've not sent me the file, so I can't show you where
you've gone wrong.
