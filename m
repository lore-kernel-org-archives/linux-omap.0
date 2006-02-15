From: Riya Patel <riya_mp0@yahoo.com>
Subject: Audio Configuration on OMAP 1510 Innovator board
Date: Wed, 15 Feb 2006 06:52:04 -0800 (PST)
Message-ID: <20060215145204.86381.qmail@web36314.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: LinuxOMap MailingList <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,
	I have problems in configuring audio on the OMAP 1510
Innovator board, for usage with the Openh323 protocol
stack.
I have the following hardware:

I am using the following software:
1. Linux 2.6.9.

I have made the following settings for audio through
Openh323 source code:
1. No. of channels: 2
2. Sample Rate: 8000 bit/s
3. Bits per sample: 16
4. Jitter buffer size: 320

With this configuration when I try to make a call from
OMAP 1510 Innovator board to another PC with H.323
terminal running on it, I am not able to hear the
voice clearly.
So, can anybody help me in identifying the problem
with the audio configuration.
It would be great if somebody can tell me the ideal
configuration for running audio applications on OMAP
1510 Innovator board.

Thanks in advance.

Regards,
Riya.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
