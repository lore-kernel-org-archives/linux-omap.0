From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 00/11] ARM/ASoC: OMAP McBSP device tree
	support
Date: Fri, 10 Aug 2012 16:15:26 +0300
Message-ID: <5025096E.8030300@bitmer.com>
References: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
 <20120808112132.GN16861@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120808112132.GN16861@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 08/08/2012 02:21 PM, Mark Brown wrote:
> On Wed, Aug 08, 2012 at 12:11:30PM +0300, Peter Ujfalusi wrote:
> 
>> The series changes McBSP related files mostly. It would be great if the whole
>> series could go via audio tree (if the patches are OK and it is fine by Tony).
> 
> I'm OK with all the patches, if Tony's happy with me applying them then
> I'll put them in a separate branch so they can easily be merged into the
> OMAP trees (or similarly if it's applied in an OMAP tree having a branch
> I can merge if needed would be good).

I suppose we could apply 1/11, 3-6/11 and 9-10 right away (2/11 perhaps
should go near 11/11?) and apply 7-8/11 (sidetone patches that increase
consumption) later?

My ack to patches 1, 3-6 and 9-10:

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
