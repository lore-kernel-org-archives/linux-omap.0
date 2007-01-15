From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [RFC][PATCH] Update MMC response types
Date: Mon, 15 Jan 2007 06:35:51 +0100
Message-ID: <45AB12B7.6020108@drzeus.cx>
References: <4586B50A.9030700@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <4586B50A.9030700@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: linux-omap-open-source@linux.omap.com, Ilias Biris <ilias.biris@indt.org.br>
List-Id: linux-omap@vger.kernel.org

Carlos Aguiar wrote:
> Hi folks,
>
> This patch is a fix in order to update MMC response types. This modification
> is needed to allow SD card support in OMAP platforms.
>
> It's based on previously work from Juha Yrjola.
>
> This modification was tested in H2 and H3 OMAP platforms using an
> Transcend SD card 512MB.
>
>   

Hmm... Actually, this patch isn't entirely needed as of the next release
as R6 is being redefined to be identical to R1 (as it should really). So
I'll make sure both make the cut for 2.6.20.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
