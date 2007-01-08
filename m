From: "Raghunandan Dhongadi" <dk.raghu@gmail.com>
Subject: Sample AIC33 loopback test
Date: Mon, 8 Jan 2007 09:20:42 +0530
Message-ID: <7d8fdf6f0701071950l54a35c9ncaa13895a433691a@mail.gmail.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello All,

Referring the e-mail on the "davinci" mailing list, I wanted to have
some advice on the following approach.

I have a OMAP2430 application and, I am trying to have the Audio Codec
AIC31B driver for I2S ( Data channel ) interface on the DSP core side,
and teh AIC31B driver for I2C ( control channel ) on the ARM code
side.

The ARM core is the master to the DSP core and shall control the
operations of the  DSP core via Codec Engine and DSP-LInk Framework.

Are there any suggestions to this approach ?

Warm Regards,
Raghu.
