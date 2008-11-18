From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Jack insertion
Date: Tue, 18 Nov 2008 11:03:43 +0000
Message-ID: <20081118110341.GA23217@sirena.org.uk>
References: <ef0d8a250811172246i411bd978h7d252b6d536e6de7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <ef0d8a250811172246i411bd978h7d252b6d536e6de7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: naveen krishna ch <naveenkrishna.ch@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 18, 2008 at 12:16:18PM +0530, naveen krishna ch wrote:

> Now my issue is is there any work regarding the Headset JACK
> insertion/detection.

> Earlier there was a proposal for a jack insertion layer.

> Can anyone suggest me in this regard.

The generic ALSA part of the API has been merged already - see
include/sound/jack.h.

For ASoC drivers you need to implement the actual detection in your
machine driver.  Normally this would just hook into a GPIO.  You can
then update the DAPM widget for the jack to mark it as in use or not in
use (some existing drivers do this) and also hook into the generic
userspace API (that's not been implemented by anyone yet).  Plan is to
get something more generic into 2.6.30.
