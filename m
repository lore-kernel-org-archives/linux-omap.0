From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 3.19 on Nokia n900: audio quality awful
Date: Wed, 28 Jan 2015 23:02:53 +0100
Message-ID: <20150128220253.GB28275@amd>
References: <20150106170433.GA5408@amd> <20150118120139.GA1509@amd>
 <54C63F1C.6010703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
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
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, sre@debian.org, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@ring0.de, jarkko.nikula@bitmer.com, pali.rohar@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon 2015-01-26 15:20:28, Peter Ujfalusi wrote:
> On 01/18/2015 02:01 PM, Pavel Machek wrote:
> > Hi!
> > 
> > If you have any idea about playback problems, help would be still
> > welcome. I'll have to do bisect, otherwise, and it will not be easy.
> > 
> >> In 3.18, sound is nice and clear.
> >>
> >> In 3.19, sound is unusable. It produces nasty tone when it should be
> >> quiet, and there's at least as much noise as is sound.
> >>
> >> Unfortunately, list of mixers also changed (and there's cca 120
> >> settings), but a) it does not work with the old list and b) nothing I
> >> could figure out did make the sound usable. Some setting resulted in
> >> even more noise.
> >>
> >> Any idea what could have caused it?
> > 
> > I tried audio recording this time.
> > 
> > In 2.6.28-nokia, it is neccessary to set "Input select" na "digital
> > mic", then it works. Input select being in "playback" option makes it
> > easy to miss.
> > 
> > In 3.18 and 3.19-rc3, all I can record are zeros.
> > 
> > Does playback/recording work for you on OMAP 3430-based machines?
> 
> Same codec (tlv320aic3106) works fine on my am335x and omap-l138 boards.
> BeagleBoard-xM also fine with twl4030 codec.
> 
> I don't have my n900 in hacking mode (it is still in use
> time-to-time) but

Actually, with nfsroot / loading kernel using NOLO, it is not
neccessary to break your n900. It is possible to boot complete
userspace without changing single bit of flash.

> looking at the dts file: you might want to add ai3x-micbias-vg property to the
> aic3x nodes to select the correct mic bias voltage. I can't recall what is
> appropriate for n900, but 2.6.28-nokia sources might give you the answer.

Ok, thanks, let me try...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
