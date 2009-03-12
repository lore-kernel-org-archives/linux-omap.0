From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: RFD: OMAP PRCM register access holding up PM branch submissions
Date: Thu, 12 Mar 2009 17:01:51 +0000
Message-ID: <20090312170151.GB7854@n2100.arm.linux.org.uk>
References: <87hc1y930c.fsf@deeprootsystems.com>
	<20090312162804.GA7179@n2100.arm.linux.org.uk>
	<87bps67kby.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <87bps67kby.fsf@deeprootsystems.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 12, 2009 at 09:54:41AM -0700, Kevin Hilman wrote:
> If you can share your opinions on the two register access approaches I
> described, I will work on coordinating development in that direction.

If I had a path forwards, then I would say so.  At the moment, I have
a vague idea about what I'd like to see, but it isn't in a workable
state at the present time.

I need to put further thought and time into coming up with a solution.
For the time being, I am not going to apply the outstanding patches to
put in place a solution which is totally confused about iomem and u32
types with lots of casts to make it work.  Even one which passes u32
types to the IO accessors (which don't produce a warning but shouldn't
be allowed in any case.)

I'm sorry, but I have no further time that I can spend on this, not even
proposing solutions, not even commenting back on the patches.  That's
the way it is.  I'm _WAY_ over time on OMAP stuff this cycle and that's
just going to have to be accepted by the community.

Sorry.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
