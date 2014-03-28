From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 58/75] ARM: l2c: omap2: remove cache size override
Date: Fri, 28 Mar 2014 15:21:59 -0700
Message-ID: <20140328222159.GB30388@atomide.com>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYZ1-0007Gn-3J@rmk-PC.arm.linux.org.uk>
 <20140328160358.GG24308@atomide.com>
 <20140328210945.GU7528@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140328210945.GU7528@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [140328 14:13]:
> On Fri, Mar 28, 2014 at 09:03:59AM -0700, Tony Lindgren wrote:
> > * Russell King <rmk+kernel@arm.linux.org.uk> [140328 08:22]:
> > 
> > Missing description?
> 
> No, I just got sick and tired of trying to write descriptions for these
> patches.  Many of these I regard as totally unnecessary patches that
> should never have been required had platform folk not invested in
> cargo cult programming.
> 
> Given the number of patches I'm presently dealing with in my tree right
> now, I don't actually have time to even follow the mailing lists at the
> moment.  If I were to properly describe all of these patches, I'd
> probably be at this for another few weeks.

Heh well I have a feeling you'll add some generic description anyways :)
 
> So, I'm at the point of "what you see is what you've got" as far as the
> descriptions go... it's going to cause me a /lot/ of pain to just add
> all the acks I'm going to need to these patches.

In that case here's one more painful ack for this patch:

Acked-by: Tony Lindgren <tony@atomide.com>
 
> And... don't expect me to send the series out again any time soon to
> LAKML - it's taken four to five hours for all these patches to filter
> through the lists.

No need to repost on my part.

Tony
