From: "Daniel Petrini" <d.pensator@gmail.com>
Subject: Re: ALSA with OMAP1510
Date: Thu, 16 Mar 2006 13:29:24 -0400
Message-ID: <9268368b0603160929vdbd5a26gaf8e81d4ef59ee0e@mail.gmail.com>
References: <9343BE359FA4224CA72A94D8CC362C9C093659@edpc500.cedt.iisc.ernet.in>
	<9268368b0603160927v6de56f8cqc8037455344a365c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9268368b0603160927v6de56f8cqc8037455344a365c@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Prakash Narayanan M <mnarayan@cedt.iisc.ernet.in>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

> > The ALSA part is compiled with kernel.  Now when I do #cat test.raw >
> > /dev/dsp no response from the audio device.  I have created and tested
> > test.raw in my host machine.
>
> You should use "aplay test.raw" to play using alsa stack.

Or even verify if OSS emulation is enabled in the kernel.

Daniel
