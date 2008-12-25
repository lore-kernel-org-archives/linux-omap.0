From: green <greenfreedom10@gmail.com>
Subject: Re: using git with linux-omap
Date: Wed, 24 Dec 2008 18:46:31 -0600
Message-ID: <20081225004631.GH4080@swansys>
References: <20081224032419.GG4080@swansys> <20081224041903.GD10240@frodo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rmUrFcWP4LYae1gV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f13.google.com ([209.85.217.13]:52526 "EHLO
	mail-gx0-f13.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbYLYArD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Dec 2008 19:47:03 -0500
Received: by gxk6 with SMTP id 6so2725778gxk.13
        for <linux-omap@vger.kernel.org>; Wed, 24 Dec 2008 16:47:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20081224041903.GD10240@frodo>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--rmUrFcWP4LYae1gV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2008.12.24, 359, Felipe Balbi wrote:
> On Tue, Dec 23, 2008 at 09:24:19PM -0600, green wrote:
> > I have cloned linux-omap-2.6 and created a local branch.  In the local =
branch I=20
> > have made one very simple commit with a single line change to Makefile =
for use=20
> > when cross-compiling (arm-linux-gnueabi-).  I would like to be able to =
rebase=20
> > that branch (just the 1 commit) onto any commit in the master branch so=
 that I=20
> > can test N810 builds using git-bisect without modifying the Makefile ev=
ery=20
> > time.  I can easily move the branch forward to the latest commit with '=
git=20
> > rebase master' (with the local branch active) but something like 'git r=
ebase=20
> > v2.6.27-omap1' returns merge errors.  Of course that 1 commit will appl=
y easily=20
> > to that specific tree.
>=20
> hmmm, something like git rebase --onto HEAD v2.6.27-omap1 <your_branch>
> should work.

I got a bunch of merge conflicts this way.

$ git rebase --onto HEAD v2.6.27-omap1 custom
First, rewinding head to replay your work on top of it...
Applying x86, ptrace: PEBS support
error: patch failed: arch/x86/Kconfig.cpu:415
error: arch/x86/Kconfig.cpu: patch does not apply
error: patch failed: arch/x86/kernel/cpu/intel.c:222
error: arch/x86/kernel/cpu/intel.c: patch does not apply
error: patch failed: arch/x86/kernel/ds.c:2
error: arch/x86/kernel/ds.c: patch does not apply
error: patch failed: arch/x86/kernel/process_32.c:316
error: arch/x86/kernel/process_32.c: patch does not apply
error: patch failed: arch/x86/kernel/process_64.c:267
error: arch/x86/kernel/process_64.c: patch does not apply
error: patch failed: arch/x86/kernel/ptrace.c:554
error: arch/x86/kernel/ptrace.c: patch does not apply
error: arch/x86/kernel/setup_64.c: does not exist in index
error: include/asm-x86/ds.h: does not exist in index
error: include/asm-x86/processor.h: does not exist in index
error: include/asm-x86/ptrace-abi.h: does not exist in index
error: include/asm-x86/ptrace.h: does not exist in index
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
Auto-merged arch/x86/Kconfig.cpu
CONFLICT (content): Merge conflict in arch/x86/Kconfig.cpu
Auto-merged arch/x86/kernel/cpu/intel.c
CONFLICT (content): Merge conflict in arch/x86/kernel/cpu/intel.c
Auto-merged arch/x86/kernel/ds.c
CONFLICT (content): Merge conflict in arch/x86/kernel/ds.c
Auto-merged arch/x86/kernel/process_32.c
CONFLICT (content): Merge conflict in arch/x86/kernel/process_32.c
Auto-merged arch/x86/kernel/process_64.c
CONFLICT (content): Merge conflict in arch/x86/kernel/process_64.c
Auto-merged arch/x86/kernel/ptrace.c
CONFLICT (content): Merge conflict in arch/x86/kernel/ptrace.c
CONFLICT (delete/modify): arch/x86/kernel/setup_64.c deleted in HEAD and=20
modified in x86, ptrace: PEBS support. Version x86, ptrace: PEBS support of=
=20
arch/x86/kernel/setup_64.c left in tree.
CONFLICT (delete/modify): include/asm-x86/ds.h deleted in HEAD and modified=
 in=20
x86, ptrace: PEBS support. Version x86, ptrace: PEBS support of=20
include/asm-x86/ds.h left in tree.
Failed to merge in the changes.
Patch failed at 0001.

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".


Thanks.

--rmUrFcWP4LYae1gV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklS1+cACgkQ682C+dBP+oTNTwCeIsRefY9sQjMtXkEb4CijgKbB
3jMAn0cu8JLZb1mrOoEzMQUdFXGGe3v1
=vIe7
-----END PGP SIGNATURE-----

--rmUrFcWP4LYae1gV--
