From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: Long Delay on startup of wl18xx Wireless chip
Date: Tue, 5 Nov 2019 20:24:15 +0100
Message-ID: <6D542255-6306-4982-9393-DCCC6D1961BB@goldelico.com>
References: <CAHCN7xJiJKBgkiRm-MF9NpgQqfV4=zSVRShc5Sb5Lya2TAxU0g@mail.gmail.com> <CAHCN7xK0Y7=Wr9Kq02CWCbQjWVOocU02LLEB=QsVB22yNNoQPw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHCN7xK0Y7=Wr9Kq02CWCbQjWVOocU02LLEB=QsVB22yNNoQPw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, "David S . Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Adam,

> Am 05.11.2019 um 19:55 schrieb Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>=20
> On Tue, Nov 5, 2019 at 12:25 PM Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>=20
>> I am seeing a really long delay at startup of the wl18xx using the =
5.4 kernel.
>>=20
>=20
> Sorry I had to resend.  I forgot to do plaintext.  Google switched
> settings on me and neglected to inform me.
>=20
>=20
>> [    7.895551] wl18xx_driver wl18xx.2.auto: Direct firmware load for =
ti-connectivity/wl18xx-conf.bin failed with error -2
>> [    7.906416] wl18xx_driver wl18xx.2.auto: Falling back to sysfs =
fallback for: ti-connectivity/wl18xx-conf.bin
>>=20
>> At this point in the sequence, I can login to Linux, but the WL18xx =
is unavailable.
>>=20
>> [   35.032382] vwl1837: disabling
>> [   69.594874] wlcore: ERROR could not get configuration binary =
ti-connectivity/wl18xx-conf.bin: -11
>> [   69.604013] wlcore: WARNING falling back to default config
>> [   70.174821] wlcore: wl18xx HW: 183x or 180x, PG 2.2 (ROM 0x11)
>> [   70.189003] wlcore: WARNING Detected unconfigured mac address in =
nvs, derive from fuse instead.
>> [   70.197851] wlcore: WARNING This default nvs file can be removed =
from the file system
>> [   70.218816] wlcore: loaded
>>=20
>> It is now at this point when the wl18xx is available.
>>=20
>> I have the wl18xx and wlcore setup as a module so it should load =
after the filesystem is mounted.  I am not using a wl18xx-conf.bin, but =
I never needed to use this before.
>>=20
>> It seems to me unreasonable to wait 60+ seconds after everything is =
mounted for the wireless chip to become available.  Before I attempt to =
bisect this, I was hoping someone might have seen this.  I am also =
trying to avoid duplicating someone else's efforts.
>>=20
>> I know the 4.19 doesn't behave like this.

I have with v5.4-rc6 on omap5 + wl1835

root@letux:~# dmesg|fgrep wlcore
[   10.268847] wl18xx_driver wl18xx.0.auto: Direct firmware load for =
ti-connectivity/wl18xx-conf.bin failed with error -2
[   10.291610] wlcore: ERROR could not get configuration binary =
ti-connectivity/wl18xx-conf.bin: -2
[   10.303839] wlcore: WARNING falling back to default config
[   10.700055] wlcore: wl18xx HW: 183x or 180x, PG 2.2 (ROM 0x11)
[   10.703469] wlcore: WARNING Detected unconfigured mac address in nvs, =
derive from fuse instead.
[   10.703478] wlcore: WARNING This default nvs file can be removed from =
the file system
[   12.738721] wlcore: loaded
[   13.978498] wlcore: PHY firmware version: Rev 8.2.0.0.237
[   14.073765] wlcore: firmware booted (Rev 8.9.0.0.70)
[   14.096806] wlcore: down
[   14.589917] wlcore: PHY firmware version: Rev 8.2.0.0.237
[   14.693183] wlcore: firmware booted (Rev 8.9.0.0.70)
root@letux:~#=20

Hope this helps.

BR,
Nikolaus
