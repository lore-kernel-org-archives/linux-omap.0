From: "Daniel Petrini" <d.pensator@gmail.com>
Subject: RE: quick test OMAP ALSA driver on H2
Date: Tue, 15 Aug 2006 08:00:18 -0300
Message-ID: <9268368b0608150400t43fc9dfev71a0b9d366eb8286@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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
To: jzhang@ti.com
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Jian,

Did you tried aplay and other applications from alsa-utils?
In my tests I always walked through that path.

HIH,

> Hi everyone,
>
> I managed to get a H2 board and booted an ALSA enabled kernel on it. The
> kernel boot log shows "H2 TSC2101" as the #0 ALSA device. To do a quick
> test, I have manually created a pcm device node:
> /dev/snd/pcmC0D0 116, 16, c

[...]

> Regards,
>
> Jian

Regards,

Daniel
