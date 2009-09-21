From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] DSPBRIDGE: Kill CAMelCaSiNg
Date: Mon, 21 Sep 2009 16:35:50 +0300
Message-ID: <94a0d4530909210635x39e3a877m66f82dce27f5acad@mail.gmail.com>
References: <4AB2464C.6010005@ti.com>
	 <94a0d4530909210505n2871f902yb5b5885547fbaefc@mail.gmail.com>
	 <5ec8ebd50909210612r24d2fbcdm438dfb6d31c86208@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:47979 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755915AbZIUNfr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Sep 2009 09:35:47 -0400
Received: by bwz6 with SMTP id 6so1930310bwz.37
        for <linux-omap@vger.kernel.org>; Mon, 21 Sep 2009 06:35:50 -0700 (PDT)
In-Reply-To: <5ec8ebd50909210612r24d2fbcdm438dfb6d31c86208@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Sep 21, 2009 at 4:12 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Sep 21, 2009 at 3:05 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Yes, I think we should do that, and make some sort of release,
>> possibly squashing all the changes... my current branch counts 218
>> commits.
> I think it should be somehow announced before. Because, f.e., my
> patches is so big to rewrite them
> (and most of them are accepted already, although I can't see commits
> in public repository)

Indeed. I'm planning on making my own "release" and pick your patches,
but for a more "official" release we (or Omar) should make an official
announcement so people send their patches before drawing the line.

>> I did a few more cleanups (yeah, I'm too picky) and here's the resul=
t.
> Actually even this could be simplified :-)
>
>> #**
>> #* @brief - changes camel casing to ones with smaller case
>> #*
>> camel_to_norm() {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo $1 | tr '\_' '+' | sed 's/\([A-Z]\)/=
_\l\1/g' | sed
>> 's/^_\([a-z]\)/\1/g' | \
> I suppose there is could be used code like: sed -e '<expr1>; <expr2>'
> instead of two or more sed calls.
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0tr 'A-Z' 'a-z' | sed "s/\([a-z][a-z]\+\)/=
-\1-/g" | tr -d '_'| \
> tr -d '_' is the 's/_//g' expression for sed
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0tr '-' '_' | sed -e "s/_$//g" | sed -e "s=
/^_//g" | tr '+' '_' | \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0sed -e "s/__*/_/g" | sed -e "s/_\([0-9][0=
-9]*\)/\1/g" | \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0sed -e "s/^[a-z]\_\([a-z][a-z]\+\)/\1/g"
> The similar. It could be optimized to a few sed calls (perhaps even t=
o
> one call with all expressions in a sequence).

Yeah, I think this code should be re-factored, but for that I guess
we'll need a list of simple checks to make sure that we get what we
want.

>> # grab the output for only the ones we want..
>> grep "$DIR_FILE" tags | grep -v "^\!" | sed -e
>> "s/\/\^.*\"/REPLACE_1/g" > $TMPFILE
> sed could match and skip lines like grep -v 'smth.': sed -e '/^!/d; .=
=2E.'
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dos2unix -n $file $TMPFILE1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sed -e "s/\<$token\>/$new/g" =
$TMPFILE1 > $file
> dos2unix actually one expression for sed, AFAIK.

Yes, but dos2unix (or equivalent) will generate a *huge* diff, that's
why I think it should be done in a different step.

> And new sed versions (starting from 3.8?) have -i which means 'in pla=
ce'.

That would be better IMHO.

> P.S. And personally I prefer to use perl :-)

=46or this kind of usage I would prefer it as well (if the code doesn't
become obfuscated), but I'd prefer ruby myself :)

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
