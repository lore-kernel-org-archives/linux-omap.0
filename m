From: Gary Thomas <samoht.yrag-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Does USB isochronous mode work on EHCI port?
Date: Fri, 4 Jan 2013 04:20:15 -0800 (PST)
Message-ID: <6ffddeae-3f7b-4972-a485-c62ecc7e2cdb@googlegroups.com>
References: <32bbff70-2fcd-4993-92ea-385ab02f735a@googlegroups.com>
 <eb7a9da0-7556-4d8f-b7b4-bf29768082df@googlegroups.com>
Reply-To: pandaboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1068_32648178.1357302015872"
Return-path: <pandaboard+bncBCOJLZ4VRAEBBAESTODQKGQEBSAPMDI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <eb7a9da0-7556-4d8f-b7b4-bf29768082df-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/pandaboard/post?hl=en_US>, <mailto:pandaboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:pandaboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/pandaboard?hl=en_US>
Sender: pandaboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/pandaboard/subscribe?hl=en_US>,
 <mailto:pandaboard+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/pandaboard/subscribe?hl=en_US>,
 <mailto:googlegroups-manage+575825281776+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: pandaboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, balbif-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

------=_Part_1068_32648178.1357302015872
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On Thursday, January 3, 2013 9:21:19 AM UTC-7, Felipe Balbi wrote:
>
> Hi,
>
> On Wednesday, January 2, 2013 10:44:50 PM UTC+2, Gary Thomas wrote:
>>
>> I have a video adapter attached to my EHCI port which runs full speed 
>> (480Mb/s) isochronous mode.  Sadly, I never get any data from the device 
>> (it uses the EM28xx driver).
>> This same device + driver works fine on my laptop and from what I can 
>> tell looking at the module debug, it's failing when waiting for the ISOC 
>> frame data to arrive.
>>
>> Should this work?  I recall lots of discussion in the past about ISOC 
>> transfers not working on certain OMAP devices...
>>
>
> which kernel are you using ? Have you tested mainline kernel ?
>

I'm using the TI/Ubuntu kernel ( ti-ubuntu-3.4.0-1489.17)

Using the mainline would be hard as there is a lot in this kernel that 
isn't in the mainline.


> Would be cool if you could also Cc linu...-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <javascript:>and 
> linux...-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <javascript:> for
> all OMAP USB queries so you can reach all interested folks.
>
> cheers
>
> -- 
> balbi
>

------=_Part_1068_32648178.1357302015872
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, January 3, 2013 9:21:19 AM UTC-7, Felipe Balbi wrote:<=
blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;bord=
er-left: 1px #ccc solid;padding-left: 1ex;">Hi,<br><br>On Wednesday, Januar=
y 2, 2013 10:44:50 PM UTC+2, Gary Thomas wrote:<blockquote class=3D"gmail_q=
uote" style=3D"margin:0;margin-left:0.8ex;border-left:1px #ccc solid;paddin=
g-left:1ex"><div>I have a video adapter attached to my EHCI port which runs=
 full speed (480Mb/s) isochronous mode. &nbsp;Sadly, I never get any data f=
rom the device (it uses the EM28xx driver).</div><div>This same device + dr=
iver works fine on my laptop and from what I can tell looking at the module=
 debug, it's failing when waiting for the ISOC frame data to arrive.</div><=
div><br></div><div>Should this work? &nbsp;I recall lots of discussion in t=
he past about ISOC transfers not working on certain OMAP devices...</div></=
blockquote><div><br></div><div>which kernel are you using ? Have you tested=
 mainline kernel ?</div></blockquote><div><br></div><div>I'm using the TI/U=
buntu kernel (&nbsp;ti-ubuntu-3.4.0-1489.17)</div><div><br></div><div>Using=
 the mainline would be hard as there is a lot in this kernel that isn't in =
the mainline.</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: =
1ex;"><div><br></div><div>Would be cool if you could also Cc <a href=3D"jav=
ascript:" target=3D"_blank" gdf-obfuscated-mailto=3D"xLFeTlVbl0QJ">linu...@=
vger.kernel.org</a> and&nbsp;<a href=3D"javascript:" target=3D"_blank" gdf-=
obfuscated-mailto=3D"xLFeTlVbl0QJ">linux...-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> for</div><d=
iv>all OMAP USB queries so you can reach all interested folks.</div><div><b=
r></div><div>cheers</div><div><br></div><div>--&nbsp;</div><div>balbi</div>=
</blockquote>
------=_Part_1068_32648178.1357302015872--
