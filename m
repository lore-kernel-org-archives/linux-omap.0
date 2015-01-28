From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 3.19 on Nokia n900: audio quality awful
Date: Wed, 28 Jan 2015 23:41:44 +0100
Message-ID: <20150128224144.GA28956@amd>
References: <20150106170433.GA5408@amd> <20150118120139.GA1509@amd>
 <54C63F1C.6010703@ti.com> <54C92752.9000004@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <54C92752.9000004@bitmer.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, sre@debian.org, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@ring0.de, pali.rohar@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed 2015-01-28 20:15:46, Jarkko Nikula wrote:
> On 01/26/2015 03:20 PM, Peter Ujfalusi wrote:
> > On 01/18/2015 02:01 PM, Pavel Machek wrote:
> >> In 2.6.28-nokia, it is neccessary to set "Input select" na "digital
> >> mic", then it works. Input select being in "playback" option makes it
> >> easy to miss.
> >>
> >> In 3.18 and 3.19-rc3, all I can record are zeros.
> >>
> >> Does playback/recording work for you on OMAP 3430-based machines?
> > 
> > Same codec (tlv320aic3106) works fine on my am335x and omap-l138 boards.
> > BeagleBoard-xM also fine with twl4030 codec.
> > 
> > I don't have my n900 in hacking mode (it is still in use time-to-time) but
> > looking at the dts file: you might want to add ai3x-micbias-vg property to the
> > aic3x nodes to select the correct mic bias voltage. I can't recall what is
> > appropriate for n900, but 2.6.28-nokia sources might give you the answer.
> > 
> No need to go that far. N900 has been supported in mainline since 2.6.39
> or so. Part A of AIC34 (which is basically dual AIC33 in a same package)
> drives 2 V for the digital microphone bias and part B 2.5 V for the headset.

Let me try... Umm, no change here :-(

root@n900:/tmp# arecord delme
Recording WAVE 'delme' : Unsigned 8 bit, Rate 8000 Hz, Mono
^CAborted by signal Interrupt...
root@n900:/tmp# hexdump delme
0000000 4952 4646 987c 0000 4157 4556 6d66 2074
0000010 0010 0000 0001 0001 1f40 0000 1f40 0000
0000020 0001 0008 6164 6174 9858 0000 8080 8080
0000030 8080 8080 8080 8080 8080 8080 8080 8080
*
0009880
root@n900:/tmp# aplay delme
Playing WAVE 'delme' : Unsigned 8 bit, Rate 8000 Hz, Mono
root@n900:/tmp#

I did this:

I'm not sure which one is "main" microphone and which is headset, but
I guess 2V should be "close enough" to 2.5V to produce something
different from zeros..?

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 48b0987..f18a5b0 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -491,6 +491,8 @@
 		DRVDD-supply = <&vmmc2>;
 		IOVDD-supply = <&vio>;
 		DVDD-supply = <&vio>;
+
+		ai3x-micbias-vg = <1>;
 	};
 
 	tlv320aic3x_aux: tlv320aic3x@19 {
@@ -502,6 +504,8 @@
 		DRVDD-supply = <&vmmc2>;
 		IOVDD-supply = <&vio>;
 		DVDD-supply = <&vio>;
+
+		ai3x-micbias-vg = <1>;
 	};
 
 	tsl2563: tsl2563@29 {

> Unfortunately I haven't had time recently to try what might have caused
> that regression after 3.18.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
