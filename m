From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 01/11] ASoC: OMAP: HDMI: Introduce codec
Date: Fri, 18 May 2012 11:55:17 -0500
Message-ID: <4FB67EF5.4010903@ti.com>
References: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>
	<1337323363-11449-2-git-send-email-ricardo.neri@ti.com>
	<20120518163240.GM4039@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120518163240.GM4039@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: x0055901@ti.com, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, lrg@ti.com
List-Id: linux-omap@vger.kernel.org

On 05/18/2012 11:32 AM, Mark Brown wrote:
> On Fri, May 18, 2012 at 01:42:33AM -0500, Ricardo Neri wrote:
>> Introduce codec for HDMI. At the moment, this is a dummy codec. In the
>> future it will parse the EDID to modify the supported parameters, such
>> as the number of channels and the sample rates. At the moment, it blindly
>> supports all the sample rates and audio channels described in the HDMI
>> 1.4a specification.
>
> Applied this one, though I had to manually fix up the Kconfig and
> Makefile - you should always submit against the current development
> tree.

Thanks Mark! Sorry for the inconvenience, I will use the development 
tree in the future.
