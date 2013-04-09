From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC v2] dmaengine: omap-dma: Start DMA without delay for cyclic
 channels
Date: Tue, 9 Apr 2013 12:20:17 +0200
Message-ID: <5163EB61.3000507@ti.com>
References: <1364987862-14597-1-git-send-email-peter.ujfalusi@ti.com>
 <51626D88.8020809@ti.com> <20130408170956.GX30923@n2100.arm.linux.org.uk>
 <20130408171519.GP10155@atomide.com> <5163BAA8.7040502@ti.com>
 <5163C103.8020101@ti.com> <20130409072600.GA31193@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130409072600.GA31193@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, Peter Meerwald <pmeerw@pmeerw.net>, Dan Williams <djbw@fb.com>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On 04/09/2013 09:26 AM, Vinod Koul wrote:
> Yes it should go thru dmaengine tree, sorry was travelling hence the dela=
y, pls
> resend the patch and I will do the needful

I already have the patch rebased on today's linux-next, just waiting for
Russell to confirm that I can add his Acked-by to the patch.
I take this from Russell as ACK: "Now that I'm back from a short 4 day brea=
k,
then yes, and the answer is that it's fine.  Who's handling the patch?"

But I want to be sure I can add that line...

-- =

P=E9ter
