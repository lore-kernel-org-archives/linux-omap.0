From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: 3.19 on Nokia n900: audio quality awful
Date: Wed, 28 Jan 2015 20:15:46 +0200
Message-ID: <54C92752.9000004@bitmer.com>
References: <20150106170433.GA5408@amd> <20150118120139.GA1509@amd>
 <54C63F1C.6010703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <54C63F1C.6010703@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com
List-Id: linux-omap@vger.kernel.org

On 01/26/2015 03:20 PM, Peter Ujfalusi wrote:
> On 01/18/2015 02:01 PM, Pavel Machek wrote:
>> In 2.6.28-nokia, it is neccessary to set "Input select" na "digital
>> mic", then it works. Input select being in "playback" option makes it
>> easy to miss.
>>
>> In 3.18 and 3.19-rc3, all I can record are zeros.
>>
>> Does playback/recording work for you on OMAP 3430-based machines?
> 
> Same codec (tlv320aic3106) works fine on my am335x and omap-l138 boards.
> BeagleBoard-xM also fine with twl4030 codec.
> 
> I don't have my n900 in hacking mode (it is still in use time-to-time) but
> looking at the dts file: you might want to add ai3x-micbias-vg property to the
> aic3x nodes to select the correct mic bias voltage. I can't recall what is
> appropriate for n900, but 2.6.28-nokia sources might give you the answer.
> 
No need to go that far. N900 has been supported in mainline since 2.6.39
or so. Part A of AIC34 (which is basically dual AIC33 in a same package)
drives 2 V for the digital microphone bias and part B 2.5 V for the headset.

Unfortunately I haven't had time recently to try what might have caused
that regression after 3.18.

-- 
Jarkko
