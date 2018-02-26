From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: regression v4.16 on Nokia N900: sound does not work
Date: Mon, 26 Feb 2018 16:02:22 +0200
Message-ID: <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
References: <20180224214617.GA22619@amd>
 <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
 <20180226131318.GA14045@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180226131318.GA14045@amd>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>
Cc: martijn@brixit.nl, Linux-ALSA <alsa-devel@alsa-project.org>, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, Mark Brown <broonie@kernel.org>, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, peter.ujfalusi@ti.com, =?UTF-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Thorsten Leemhuis <regressions@leemhuis.info>, abcloriens@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, sakari.ailus@linux.intel.com, pali.rohar@gmail.com, clayton@craftyguy.net, linux-omap@vger.kernel.org, patrikbachan@gmail.com, "Andrew F . Davis" <afd@ti.com>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 26, 2018 at 3:13 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> JFYI: This issues is tracked in the regression reports for Linux 4.16
>> (http://bit.ly/lnxregrep416 ) with this id:
>>
>> Linux-Regression-ID: lr#4b650f
>
> Ok, so it seems that issue is bigger: whole sound subsystem does not
> work. /proc/asound/cards is empty.
>
> 7e6127c1240ed569cdda2a67c8f03836f9f28c05 seems to be bad already.
>
> I tried to revert sound/soc changes, and sound is broken, too. Nasty


dmesg log?
