From: Liam Breck <liam@networkimprov.net>
Subject: Fwd: power: supply: bq27xxx: enable writing capacity values for bq27500
Date: Fri, 1 Sep 2017 13:09:34 -0700
Message-ID: <CAKvHMgTtxYUXGmCOq3MEB5-r3xvuR7RoCdMPkq2CTHBXvw-+7g@mail.gmail.com>
References: <CAKvHMgRhmRKsC-2DrxD0sx3rXBN9xyv3W9cbXAUO7oTHEawm8Q@mail.gmail.com>
 <CAKvHMgTTUuoaSMON6o=+chBv53aSZrDukz06DTdOYYGtTbovag@mail.gmail.com>
 <CAKvHMgSztFGS_KmeNoT7Fe-xTpgiH_-Y3=Us_QCtK9FzMM67kg@mail.gmail.com>
 <CAKvHMgTH7-e7TTKj--5HjDCV5kZCr_=aY73wRRePMDiLPdE55g@mail.gmail.com>
 <CAKvHMgR6jEjY08v95mYenHo=V+n59EfFVFb8R+P_Mx8kHJc+3A@mail.gmail.com>
 <CAKvHMgTDwhbXerhybL1=WemLmn_fpKWdhmZPVvGPQ_Xzu-m1Uw@mail.gmail.com>
 <CAKvHMgQVQYcyS-Ku7VeNLoZ6MtP331nbfooskiHM9wuF1pC9gQ@mail.gmail.com>
 <CAKvHMgQ+W-mX4TMo4ggiVJZ=8==Okr5ZeD_A84SfGYshA1Zn3Q@mail.gmail.com>
 <CAKvHMgQGhqG_5WcDO9Ovt9wp1oxy-08RbyMR5gcLNeiYdeXAeg@mail.gmail.com>
 <CAKvHMgTDaoLcw80Y7inM3sqc5r5fgVb3TYSfARg=3QBXOWhJ0w@mail.gmail.com>
 <CAKvHMgRBnktcaxF2GKGMUSbctQsUK-UFf8S1mBMR5dP4Tw8htA@mail.gmail.com> <CAKvHMgSpyAUsm-AH9eO7KAzuxxfKsOROtRqx=-KfuqprwWRMYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAKvHMgSpyAUsm-AH9eO7KAzuxxfKsOROtRqx=-KfuqprwWRMYw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

[resend in plaintext]

Hi Sebastian,

This chip definition, enabled by this patch from Nikolaus, is not
fully tested yet. I just sent him a new fix to try, and his previous
kernel logs for it aren't definitely correct.

Could you drop this from -next? Hopefully he'll have a new patch for
you shortly...

power: supply: bq27xxx: enable writing capacity values for bq27500
https://patchwork.kernel.org/patch/9931511/

Cc Tony re OpenPandora dtsi patches
