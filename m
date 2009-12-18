From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/3] ASoC: OMAP4: Add support for McPDM
Date: Fri, 18 Dec 2009 13:13:55 +0200
Message-ID: <20091218111355.GF32312@nokia.com>
References: <2256F256009DAA4CBE661E9F41EAC84B8BA0A6D2@dlee01.ent.ti.com>
	<20091217202821.GA30379@nokia.com>
	<20091218105129.GB19544@sirena.org.uk>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20091218105129.GB19544@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ext Candelaria Villareal, Jorge" <x0107209@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 18, 2009 at 11:51:30AM +0100, ext Mark Brown wrote:
>On Thu, Dec 17, 2009 at 10:28:21PM +0200, Felipe Balbi wrote:
>> On Thu, Dec 17, 2009 at 08:40:32PM +0100, ext Candelaria Villareal, Jorge wrote:
>
>> >+config SND_OMAP_SOC_MCPDM
>> >+       tristate
>
>> look at how SND_OMAP_SOC_N810 is done, can't you follow that ? put some
>> description ad help ?
>
>This is fine - DAI drivers should be selected by machine drivers rather
>than by users since they are useless without the machine drivers.  This
>means that they shouldn't have a description.
>
>> >+EXPORT_SYMBOL(omap_mcpdm_start);
>> >+EXPORT_SYMBOL(omap_mcpdm_stop);
>> >+EXPORT_SYMBOL(omap_mcpdm_set_uplink);
>> >+EXPORT_SYMBOL(omap_mcpdm_set_downlink);
>> >+EXPORT_SYMBOL(omap_mcpdm_clr_uplink);
>> >+EXPORT_SYMBOL(omap_mcpdm_clr_downlink);
>> >+EXPORT_SYMBOL(omap_mcpdm_request);
>> >+EXPORT_SYMBOL(omap_mcpdm_free);
>
>> way too many exported symbols, no ? Doesn't ALSA API have proper place
>> for this kind of stuff ? I'd need ALSA experts to reply to that but it
>> does smell funny...
>
>With the McBSP these things are all exported because the McBSP isn't
>just used by ALSA, I beleive, but a PDM interface is probably only ever
>going to be used by audio.

thanks for the explanation :-)

-- 
balbi
