From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [RESEND PATCH v3 11/11] ARM/dts: am335x-evm: Add
 audio support for am335x-evm.dts
Date: Tue, 8 Oct 2013 14:37:35 +0300
Message-ID: <5253EE7F.1000303@ti.com>
References: <cover.1379590035.git.jsarha@ti.com>
 <cd7271a46f1c6937039b749ed105afa8057b9770.1379590036.git.jsarha@ti.com>
 <20131007220245.GE2976@kartoffel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20131007220245.GE2976@kartoffel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "joelf@ti.com" <joelf@ti.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, Darren Etheridge <detheridge@ti.com>, "broonie@kernel.org" <broonie@kernel.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 10/08/2013 01:02 AM, Mark Rutland wrote:
>> +&mcasp1 {
>> >+		pinctrl-names = "default";
>> >+		pinctrl-0 = <&am335x_evm_audio_pins>;
> I didn't see mention of pinctrl added to the binding. It should be.

I'll add that. Thanks!

Cheers,
Jyri
