From: Mike Turquette <mturquette@ti.com>
Subject: Re: [RFC][PATCH 0/5] Introduce .get_voltage callback into voltdm
Date: Fri, 26 Oct 2012 12:40:21 -0700
Message-ID: <20121026194021.3141.73709@nucleus>
References: <1349313365-5262-1-git-send-email-mturquette@ti.com>
 <87fw51hzcg.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87fw51hzcg.fsf@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Quoting Kevin Hilman (2012-10-26 11:17:51)
> Hi Mike,
> 
> Mike Turquette <mturquette@ti.com> writes:
> 
> > From: Mike Turquette <mturquette@linaro.org>
> >
> > This series creates a new callback for struct voltagedomain,
> > .get_voltage.  This fetches the voltage from hardware, if possible, and
> > returns it to the caller.  We use this call to populate
> > voltdm->nominal_volt at boot time.
> 
> I pointed out a couple nitpicky things on individual patches, but
> otherwise this direction and motiviation for this series looks OK by me.
> 
> Just some minor comments about the structure of the series.  I tend to
> prefer combining the introduction of a new function with it's usage.  It
> makes review and understanding much easier, IMO.  If there are reasons
> to keep them separate, that's fine too.  Just describe the reasons in
> the cover letter.
> 

Will do.  I've thought on this topic a bit more and this approach isn't
quite robust enough.  For instance it assumes that the kernel's voltage
scaling approach (vp_forceupdate vs. vc_bypass) matches what the
bootloader does.  This is of course an unsafe assumption.

Also I've seen the Android guys struggle with this a bit and I'd like to
review how they approached the problem before sending my next series.
Couple with upcoming travel I'm not sure how quickly I'll get a V2 on
the list.

Thanks for reviewing,
Mike

> Thanks,
> 
> Kevin
