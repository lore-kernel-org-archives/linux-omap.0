From: Tony Lindgren <tony@atomide.com>
Subject: Re: Command Time-Out values in MMC
Date: Sat, 28 Jan 2006 12:36:24 -0800
Message-ID: <20060128203624.GD17374@atomide.com>
References: <fb249edb0601281148g745d146cy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0601281148g745d146cy@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: andrzej zaborowski <balrogg@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrogg@gmail.com> [060128 11:55]:
> Hi,
> while browsing the MMC driver sources I noticed that the CTO (Command
> Time-Out) register is written a value 0xff in one place (exactly,
> here: http://www.kernel.org/git/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=blob;h=35708dbf9d8e0f41687caeb70e7dde3f216a86a9;hb=9ca18d5394c5e6b2c74ddc52abaed81df530ff1d;f=drivers/mmc/omap.c#l847),
> while the OMAP5910 documentation (exactly, this document:
> http://focus.ti.com/dsp/docs/dspsupporttechdocsc.tsp?sectionId=3&tabId=409&familyId=325&abstractName=spru680)
> states something like:
> [...]
> 0x01: One clock cycle
> 0xFD: 253 clock cycles
> The 0xFF and 0xFE cannot be used.
> [...]
> 
> Is this intentional? It seems to cause no problems, but setting 0xfd
> instead also didn't break anything for me. Is this limit also
> mentioned in documentation for other OMAP boards?
> (If this is intentional, please ignore me.)

As far as I remember we're not using the command timeout currently and it
was expiring with some cards and causing false errors.

Basically some blocks on some cards take a really long time to write to.
And if the command timeout expires before the card is done, we get a
false error.

Tony
