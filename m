From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: Long Delay on startup of wl18xx Wireless chip
Date: Wed, 6 Nov 2019 11:38:24 +0100
Message-ID: <7BC95BF7-0E1D-4863-AB71-37BB6E8E297E@goldelico.com>
References: <CAHCN7xJiJKBgkiRm-MF9NpgQqfV4=zSVRShc5Sb5Lya2TAxU0g@mail.gmail.com> <CAHCN7xK0Y7=Wr9Kq02CWCbQjWVOocU02LLEB=QsVB22yNNoQPw@mail.gmail.com> <87sgn1z467.fsf@codeaurora.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <87sgn1z467.fsf@codeaurora.org>
Sender: netdev-owner@vger.kernel.org
To: Kalle Valo <kvalo@codeaurora.org>, Adam Ford <aford173@gmail.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, linux-wireless@vger.kernel.org, netdev <netdev@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


> Am 06.11.2019 um 11:32 schrieb Kalle Valo <kvalo@codeaurora.org>:
>=20
> Adam Ford <aford173@gmail.com> writes:
>=20
>> On Tue, Nov 5, 2019 at 12:25 PM Adam Ford <aford173@gmail.com> wrote:
>>>=20
>>> I am seeing a really long delay at startup of the wl18xx using the =
5.4 kernel.
>>>=20
>>=20
>> Sorry I had to resend.  I forgot to do plaintext.  Google switched
>> settings on me and neglected to inform me.
>>=20
>>=20
>>> [ 7.895551] wl18xx_driver wl18xx.2.auto: Direct firmware load for
>>> ti-connectivity/wl18xx-conf.bin failed with error -2
>>> [ 7.906416] wl18xx_driver wl18xx.2.auto: Falling back to sysfs
>>> fallback for: ti-connectivity/wl18xx-conf.bin
>>>=20
>>> At this point in the sequence, I can login to Linux, but the WL18xx =
is unavailable.
>>>=20
>>> [   35.032382] vwl1837: disabling
>>> [ 69.594874] wlcore: ERROR could not get configuration binary
>>> ti-connectivity/wl18xx-conf.bin: -11
>>> [   69.604013] wlcore: WARNING falling back to default config
>>> [   70.174821] wlcore: wl18xx HW: 183x or 180x, PG 2.2 (ROM 0x11)
>>> [ 70.189003] wlcore: WARNING Detected unconfigured mac address in
>>> nvs, derive from fuse instead.
>>> [   70.197851] wlcore: WARNING This default nvs file can be removed =
from the file system
>>> [   70.218816] wlcore: loaded
>>>=20
>>> It is now at this point when the wl18xx is available.
>>>=20
>>> I have the wl18xx and wlcore setup as a module so it should load
>>> after the filesystem is mounted. I am not using a wl18xx-conf.bin,
>>> but I never needed to use this before.
>>>=20
>>> It seems to me unreasonable to wait 60+ seconds after everything is
>>> mounted for the wireless chip to become available. Before I attempt
>>> to bisect this, I was hoping someone might have seen this. I am also
>>> trying to avoid duplicating someone else's efforts.
>>>=20
>>> I know the 4.19 doesn't behave like this.
>=20
> Try disabling CONFIG_FW_LOADER_USER_HELPER, that usually causes a 60
> second delay if the user space is not setup to handle the request. (Or
> something like that.)

I can confirm that I have it disabled in our config which seems to work.

BR,
Nikolaus
