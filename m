From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: Re: ALSA with OSK
Date: Wed, 22 Mar 2006 09:07:12 -0400
Message-ID: <44214C00.3060302@indt.org.br>
References: <442020C6.1060203@gmail.com> <442072B2.5050005@cc.jyu.fi>
	<4420F44F.9010900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4420F44F.9010900@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

ext Dirk Behme wrote:
> Thanks! Does aplay play mp3? I applied the patches, but no difference:

aplay doesn't support mp3 files. You can try this command instead:

madplay -q -o raw:- file.mp3 | aplay -q -f cd

It uses madplay just for mp3 decoding and aplay to actually "talk" with alsa.

Best Regards,

Anderson Briglia
