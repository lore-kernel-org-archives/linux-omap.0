From: dinesh <dinesh.dua@coraltele.com>
Subject: REGISTER 2 PCM FOR SAME DEVICE
Date: Thu, 04 Sep 2008 18:10:43 +0530
Message-ID: <1220532043.25078.6.camel@dinesh.dua>
References: <1220504520-6067-1-git-send-email-sakoman@gmail.com>
	<1220504520-6067-2-git-send-email-sakoman@gmail.com>
	<1220504520-6067-3-git-send-email-sakoman@gmail.com>
	<1220504520-6067-4-git-send-email-sakoman@gmail.com>
	<20080904132632.e64c3ce2.jarkko.nikula@nokia.com>
	<20080904122542.GC21663@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20080904122542.GC21663@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "ext sakoman@gmail.com" <sakoman@gmail.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>, Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org

Hi,

I have made a sound driver similar to mpc5200_psc.c and tlv codec.
I have 2 channels which are interleaved.

I want to register these two channels as different devices on same card,
How can i do it.

Thanks,
Dinesh Dua
