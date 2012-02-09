From: Teresa Gamez <T.Gamez@phytec.de>
Subject: Re: [PATCH 00/16] rmk's patch series for fixing OMAP
Date: Thu, 09 Feb 2012 09:30:20 +0100
Message-ID: <1328776220.12747.5.camel@lws-gamez>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <4F32DBB5.4010004@gmx.de>  <20120209005334.GG25414@n2100.arm.linux.org.uk>
 <1328770969.1909.11.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1328770969.1909.11.camel@deskari>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-fbdev@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

Am Donnerstag, den 09.02.2012, 09:02 +0200 schrieb Tomi Valkeinen:
> On Thu, 2012-02-09 at 00:53 +0000, Russell King - ARM Linux wrote:
> 
> > Moreover, only last Monday did I enable the OMAP2 DSS subsystem on the
> > 4430 SDP platform, _including_ the HDMI code, and looking at the commit
> > it could be one of those platforms which is affected.
> > 
> > As I don't have a HDMI cable connected to the system, and I ran that
> > kernel overnight, and I tried opening each /dev/fb* device, what I'm now
> > wondering is: have I destroyed the HDMI PHY on my 4430SDP?
> 
> Probably not. I don't know the exact details of the HW bug (I wrote the
> patch as it took too long for the person responsible for it to come up
> with a decent patch), but my understanding is that the cable needs to be
> plugged in at some point, and then removed.
> 
> Thinking about this now, I guess I should've sent queries to get a
> proper description of the situation where the bug happens.
> 
> > However, you raise another point, a much more serious one at that.  Is
> > this problem also present in 3.2?  The patch seems to apply almost cleanly
> > to that kernel version, so I guess it is.  It fails to apply to v3.1
> > because of missing files, so I guess 3.1 is unaffected.
> > 
> > So, why isn't this patch copied to the stable people?
> 
> Good point, I'll take it to the stable people.
> 
> The problem is present in all kernels where we have the HDMI driver, so
> 2.6.39+.

Are there already backported patches out there for 3.0/3.1?
We are quite interested in this.

Regards,
Teresa

> 
> > For hardware destruction issues, once the problem has been identified, it
> > should be shouted about very loudly to get it upstream as quickly as
> > possible.  I'm sure Linus would've even taken it in patch form.
> > 
> > (You do realise that Linus does apply patches as well as pulling trees?)
> 
> Yes, I should've taken this directly to Linus.
> 
>  Tomi
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
