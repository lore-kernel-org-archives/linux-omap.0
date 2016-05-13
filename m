From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 0/7] ARM/ASoC: OMAP3: Fix McBSP2/3
	sidetone support
Date: Fri, 13 May 2016 14:45:34 +0300
Message-ID: <f7af7b30-563a-0048-9696-6ad0125d8f68@ti.com>
References: <1461927202-17677-1-git-send-email-peter.ujfalusi@ti.com>
 <69ff65ee-e5d1-09fb-fd91-8d7b4d8fdda4@ti.com>
 <20160512164201.GQ5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160512164201.GQ5995@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, paul@pwsan.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

On 05/12/16 19:42, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160511 01:46]:
>> Tony, Paul,
>>
>> On 04/29/16 13:53, Peter Ujfalusi wrote:
>>> Hi,
>>>
>>> Based on the ongoing discussion on v2 (ARM: OMAP3: Fix McBSP2/3 hwmod s=
etup for
>>> sidetone) I have dropped the removal of the sidetone hwmod and only cor=
rected
>>> it. The series now includes all related changes needed to have correct =
sidetone
>>> support whenever we boot in legacy or in DT mode.
>>>
>>> This time the ASoC part have dependency on earlier patches so they can =
not be
>>> applied separately.
>>
>> How should we proceed from here? I don't want to start designing the ST
>> separation infrastructure which would be based on this series, but if th=
ere
>> are outstanding issues found on this, I would need to go back to the dra=
wing
>> board.
>> The separation will be mostly new code and code shuffle in ASoC, but for
>> legacy I will need to build up something in arch as well, so I would nee=
d at
>> least one release cycle to start with things.
> =

> Well looks like we have all the acks, so I can apply these. We have
> not heard from Paul on this for a while, so let's wait few days for
> that.
> =

> Meanwhile, Mark wanted to fix the subject for one of the patches, care
> to repost that at least? Or the whole series with acks, could be a
> pull request too against v4.6-rc1 :)

Thanks, I'll wait for couple of days for Paul to review and I will prepare =
v4
and a pull request.

-- =

P=E9ter
