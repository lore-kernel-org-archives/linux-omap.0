From: RobertChou <rbtchc@gmail.com>
Subject: Question about microphone usage on OMAP2430SDP
Date: Wed, 24 Jan 2007 09:57:53 +0800
Message-ID: <dbf1574b0701231757o7186a24dk39d9483ae371eab5@mail.gmail.com>
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

hi,

  I'm trying to record some voice through Main/Sub & Headset microphone on
OMAP2430SDP board. But only noises is recorded (does not sound like voice).

  I have used
    1. cat /dev/dsp > audio.out & cat audio.out > /dev/dsp   --> failed
    2. sample program from pjsip (open source sip protocol stack)
        which config. sample rate=44100, ch=2, bits=16
        (able to record sound in x86 system)                        --> failed

   Besides main/sub mic, I noticed that the record source can be switch to
Headset by ioctl OSS driver. I tried to use audio connector to 3.5mm microphone
to the headset plug. But still doesn't work.

   I'm using linux-2.6.14-omap2430 downloaded from TI webiste. Does anyone ever
successfully record anything from OMAP2430 main/sub or headset mic? And how
can i correctly connect microphone to on-board headset plug? I'm currently using
audio connector grab from nokia mobile accessory. Thx for answering my question.

Best Regards,

Robert
