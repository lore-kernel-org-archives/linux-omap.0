From: "Mano" <mano@mangotechno.com>
Subject: Recommended source for H3
Date: Fri, 23 Nov 2007 16:14:37 +0530
Message-ID: <IHENIOMDPMGBEGEFMMDPMEHPCAAA.mano@mangotechno.com>
Reply-To: mano@mangotechno.com
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi people,

I started developing on H3 and successfully ported
our framework on H3 based on :
http://focus.ti.com/general/docs/wtbu/wtbusplashcontent.tsp?templateId=6123&
contentId=4750#h3

However I am facing some challenges integrating
other features like audio, touchscreen.

I tried to use OSS audio on 2.6.9 but there
was problem with mp3 playback with mpg123.

I tried enabling touchscreen functionality but
faced problems calibrating with 2.6.9. Similarly
2.6.18 gave problem because of absence of devfs.
the ts_xxx programs won't run. Also audio was a
problem here.

Can someone please recommend a good kernel source
to do the development?

I would like to use the following features:
Touchscreen
Audio
SD Card.

thanks,
Mano Bangera
www.mangotechno.com

No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.5.503 / Virus Database: 269.16.3/1144 - Release Date: 11/21/2007
4:28 PM
